-- ============================================================
-- UCJIMS - Person C queries, view, procedure, function

-- ============================================================

-- ---------- 1. JOIN QUERIES ----------

-- 1a. Case -> hearings -> judge -> court
SELECT c.case_id, c.case_number, c.case_type,
       h.hearing_id, h.hearing_date, h.hearing_type, h.hearing_status,
       u.full_name AS judge_name, ct.court_name
FROM CASE_TABLE c
JOIN HEARING h   ON h.case_id = c.case_id
JOIN APP_USER u  ON u.user_id = h.judge_id
JOIN COURT ct    ON ct.court_id = h.court_id
ORDER BY c.case_id, h.hearing_date;

-- 1b. Judgment -> sentence -> inmate -> prison
SELECT j.judgment_id, j.case_id, j.verdict,
       p.full_name AS convict_name,
       s.sentence_type, s.duration, s.fine_amount,
       i.inmate_id, i.status AS inmate_status,
       pr.prison_name
FROM JUDGMENT j
JOIN SENTENCE s       ON s.judgment_id = j.judgment_id
JOIN PERSON p         ON p.person_id = s.person_id
LEFT JOIN INMATE i    ON i.sentence_id = s.sentence_id
LEFT JOIN PRISON pr   ON pr.prison_id = i.prison_id
ORDER BY j.judgment_id;

-- 1c. Legal provisions applied per case
SELECT c.case_id, c.case_number, lp.act_name, lp.section_number, lp.description
FROM CASE_PROVISION cp
JOIN CASE_TABLE c        ON c.case_id = cp.case_id
JOIN LEGAL_PROVISION lp  ON lp.provision_id = cp.provision_id
ORDER BY c.case_id;

-- ---------- 2. REPORT QUERIES ----------

-- 2a. Hearings per court by status
SELECT ct.court_name,
       COUNT(*) AS total_hearings,
       SUM(CASE WHEN h.hearing_status = 'COMPLETED' THEN 1 ELSE 0 END) AS completed,
       SUM(CASE WHEN h.hearing_status = 'ADJOURNED' THEN 1 ELSE 0 END) AS adjourned,
       SUM(CASE WHEN h.hearing_status = 'SCHEDULED' THEN 1 ELSE 0 END) AS scheduled
FROM COURT ct
LEFT JOIN HEARING h ON h.court_id = ct.court_id
GROUP BY ct.court_name
ORDER BY total_hearings DESC;

-- 2b. Upcoming hearings
SELECT h.hearing_id, h.case_id, h.hearing_date, h.hearing_type,
       ct.court_name, u.full_name AS judge_name
FROM HEARING h
JOIN COURT ct   ON ct.court_id = h.court_id
JOIN APP_USER u ON u.user_id = h.judge_id
WHERE h.hearing_status = 'SCHEDULED' AND h.hearing_date >= TRUNC(SYSDATE)
ORDER BY h.hearing_date;

-- 2c. Inmates due for release in the next 90 days
SELECT i.inmate_id, p.full_name, pr.prison_name, i.expected_release_date,
       TRUNC(i.expected_release_date - SYSDATE) AS days_left
FROM INMATE i
JOIN PERSON p   ON p.person_id = i.person_id
JOIN PRISON pr  ON pr.prison_id = i.prison_id
WHERE i.status = 'INCARCERATED'
  AND i.expected_release_date BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) + 90
ORDER BY i.expected_release_date;

-- 2d. Prison transfer history
SELECT t.transfer_id, p.full_name AS inmate_name,
       fp.prison_name AS from_prison, tp.prison_name AS to_prison,
       t.transfer_date, t.reason
FROM PRISON_TRANSFER t
JOIN INMATE i       ON i.inmate_id = t.inmate_id
JOIN PERSON p       ON p.person_id = i.person_id
LEFT JOIN PRISON fp ON fp.prison_id = t.from_prison_id
LEFT JOIN PRISON tp ON tp.prison_id = t.to_prison_id
ORDER BY t.transfer_date;

-- ---------- 3. FUNCTION ----------

CREATE OR REPLACE FUNCTION GET_PRISON_OCCUPANCY (p_prison_id IN NUMBER)
RETURN NUMBER
IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM INMATE
  WHERE prison_id = p_prison_id AND status = 'INCARCERATED';
  RETURN v_count;
END;
/

-- 2e. Occupancy vs capacity (uses the function)
SELECT pr.prison_id, pr.prison_name, pr.capacity,
       GET_PRISON_OCCUPANCY(pr.prison_id) AS current_inmates,
       ROUND(GET_PRISON_OCCUPANCY(pr.prison_id) / pr.capacity * 100, 1) AS occupancy_pct
FROM PRISON pr
ORDER BY pr.prison_id;

-- ---------- 4. PROCEDURE ----------

CREATE OR REPLACE PROCEDURE RELEASE_INMATE (p_inmate_id IN NUMBER)
IS
  v_status INMATE.status%TYPE;
BEGIN
  SELECT status INTO v_status FROM INMATE WHERE inmate_id = p_inmate_id;

  IF v_status = 'RELEASED' THEN
    RAISE_APPLICATION_ERROR(-20001, 'Inmate ' || p_inmate_id || ' is already released');
  END IF;

  UPDATE INMATE
  SET actual_release_date = SYSDATE,
      status = 'RELEASED'
  WHERE inmate_id = p_inmate_id;
  -- no COMMIT here: the caller decides
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, 'Inmate ' || p_inmate_id || ' not found');
END;
/

-- Demo (rolled back so the sample data stays intact):
-- EXEC RELEASE_INMATE(1);
-- SELECT inmate_id, status, actual_release_date FROM INMATE WHERE inmate_id = 1;
-- ROLLBACK;

-- ---------- 5. VIEW ----------

CREATE OR REPLACE VIEW V_CASE_COURT_SUMMARY AS
SELECT c.case_id, c.case_number, c.case_type, c.case_status,
       (SELECT COUNT(*) FROM HEARING h WHERE h.case_id = c.case_id) AS total_hearings,
       (SELECT MAX(h.hearing_date) FROM HEARING h
         WHERE h.case_id = c.case_id AND h.hearing_status = 'COMPLETED') AS last_hearing_date,
       j.judgment_date, j.verdict,
       s.sentence_type, s.duration, s.fine_amount
FROM CASE_TABLE c
LEFT JOIN JUDGMENT j ON j.case_id = c.case_id
LEFT JOIN SENTENCE s ON s.judgment_id = j.judgment_id;

SELECT * FROM V_CASE_COURT_SUMMARY ORDER BY case_id;

-- ---------- 6. INTEGRATION QUERY (A -> B -> C) ----------
-- Cases 1 and 2 have B's evidence and forensic reports (no judgment yet).
-- Cases 4 and 14 have the full chain: evidence (from 09) -> forensics ->
-- hearings -> judgment -> sentence -> inmate -> prison.

SELECT c.case_id, c.case_number,
       acc.full_name       AS accused,
       inv.investigation_id,
       e.evidence_id, e.evidence_type,
       fr.report_id, fr.result AS forensic_result,
       (SELECT COUNT(*) FROM HEARING h WHERE h.case_id = c.case_id) AS hearings,
       j.verdict,
       s.sentence_type, s.duration,
       i.inmate_id, i.status AS inmate_status, pr.prison_name
FROM CASE_TABLE c
JOIN CASE_PERSON cp          ON cp.case_id = c.case_id AND cp.role_in_case = 'ACCUSED'
JOIN PERSON acc              ON acc.person_id = cp.person_id
LEFT JOIN INVESTIGATION inv  ON inv.case_id = c.case_id
LEFT JOIN EVIDENCE e         ON e.case_id = c.case_id
LEFT JOIN FORENSIC_REPORT fr ON fr.evidence_id = e.evidence_id
LEFT JOIN JUDGMENT j         ON j.case_id = c.case_id
LEFT JOIN SENTENCE s         ON s.judgment_id = j.judgment_id AND s.person_id = cp.person_id
LEFT JOIN INMATE i           ON i.sentence_id = s.sentence_id
LEFT JOIN PRISON pr          ON pr.prison_id = i.prison_id
WHERE c.case_id IN (1, 2, 4, 14)
ORDER BY c.case_id, e.evidence_id;

-- ---------- 7. NEGATIVE TESTS (each should FAIL) ----------
-- INSERT INTO HEARING VALUES (99, 999, 1, 4, SYSDATE, 'Test', 'CR1', 'SCHEDULED', NULL);   -- ORA-02291 bad case_id
-- INSERT INTO HEARING VALUES (99, 1, 1, 4, SYSDATE, 'Test', 'CR1', 'PENDING', NULL);        -- ORA-02290 bad status
-- INSERT INTO INMATE VALUES (99, 3, 1, 1, SYSDATE, NULL, NULL, 'ESCAPED');                  -- ORA-02290 bad status
-- INSERT INTO PRISON_TRANSFER VALUES (99, 1, 2, 2, SYSDATE, 'same prison');                 -- ORA-02290 from = to
-- INSERT INTO SENTENCE VALUES (99, 1, 40, 'Fine', NULL, 100, SYSDATE, SYSDATE - 5);         -- ORA-02290 end < start
-- ROLLBACK;