
-- PERSON B: EVIDENCE AND FORENSIC QUERIES

-- 1. Find all evidence for a case
SELECT *
FROM EVIDENCE
WHERE case_id = 1;

-- 2. Find evidence under forensic examination
SELECT *
FROM EVIDENCE
WHERE current_status = 'UNDER_EXAMINATION';

-- 3. Complete chain-of-custody history
SELECT c.custody_id,
       c.evidence_id,
       u1.full_name AS transferred_by,
       u2.full_name AS received_by,
       c.transfer_date_time,
       c.transfer_location,
       c.purpose,
       c.condition,
       c.remarks
FROM CHAIN_OF_CUSTODY c
LEFT JOIN APP_USER u1
    ON c.from_user_id = u1.user_id
LEFT JOIN APP_USER u2
    ON c.to_user_id = u2.user_id
WHERE c.evidence_id = 1
ORDER BY c.transfer_date_time;

-- 4. Evidence collected by an investigator
SELECT e.*
FROM EVIDENCE e
WHERE e.collected_by = 1;

-- 5. Forensic reports for a case
SELECT e.case_id,
       e.evidence_id,
       e.evidence_type,
       f.report_id,
       f.forensic_officer_id,
       f.examination_date,
       f.examination_details,
       f.result
FROM EVIDENCE e
JOIN FORENSIC_REPORT f
    ON e.evidence_id = f.evidence_id
WHERE e.case_id = 1;

-- 6. Current evidence status and storage location
SELECT evidence_id,
       case_id,
       evidence_type,
       current_status,
       storage_location
FROM EVIDENCE;

-- 7. Audit history of evidence transfers
SELECT *
FROM EVIDENCE_AUDIT
ORDER BY action_time;

-- 8. Evidence handled by a particular user
SELECT e.evidence_id,
       e.evidence_type,
       c.from_user_id,
       c.to_user_id,
       c.transfer_date_time,
       c.purpose
FROM EVIDENCE e
JOIN CHAIN_OF_CUSTODY c
    ON e.evidence_id = c.evidence_id
WHERE c.from_user_id = 1
   OR c.to_user_id = 1
ORDER BY c.transfer_date_time;

