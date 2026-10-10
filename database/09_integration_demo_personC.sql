-- ============================================================
-- UCJIMS - Integration demo data (shared "one connected case")
-- ============================================================

-- EVIDENCE
INSERT INTO EVIDENCE VALUES
(4, 4, 'Physical', 'Tools recovered from the burglary scene',
 TO_DATE('2024-05-12','YYYY-MM-DD'),
 'Residential premises, MG Road', 14, 'Evidence Room A', 'RETURNED');

INSERT INTO EVIDENCE VALUES
(5, 4, 'Digital', 'CCTV footage from a neighbouring shop',
 TO_DATE('2024-05-13','YYYY-MM-DD'),
 'MG Road', 14, 'Forensic Lab 1', 'RETURNED');

INSERT INTO EVIDENCE VALUES
(6, 14, 'Physical', 'Sample of seized narcotic substance',
 TO_DATE('2024-03-11','YYYY-MM-DD'),
 'Whitefield, Chennai', 1, 'Forensic Lab 1', 'DISPOSED');

-- CHAIN_OF_CUSTODY
INSERT INTO CHAIN_OF_CUSTODY VALUES
(4, 4, 14, 8,
 TO_DATE('2024-05-14 14:00','YYYY-MM-DD HH24:MI'),
 'Forensic Lab 1', 'Forensic examination', 'Sealed',
 'Handed to forensic officer for tool mark and print analysis');

INSERT INTO CHAIN_OF_CUSTODY VALUES
(5, 5, 14, 8,
 TO_DATE('2024-05-15 10:30','YYYY-MM-DD HH24:MI'),
 'Forensic Lab 1', 'Footage enhancement', 'Intact',
 'Digital copy and original storage device handed over');

INSERT INTO CHAIN_OF_CUSTODY VALUES
(6, 6, 1, 9,
 TO_DATE('2024-03-12 11:00','YYYY-MM-DD HH24:MI'),
 'Forensic Lab 1', 'Chemical analysis', 'Sealed',
 'Sample transferred for lab testing');

-- FORENSIC_REPORT
INSERT INTO FORENSIC_REPORT VALUES
(3, 4, 8,
 TO_DATE('2024-05-16','YYYY-MM-DD'),
 'Tool mark and fingerprint analysis',
 'Fingerprints matched the accused');

INSERT INTO FORENSIC_REPORT VALUES
(4, 5, 8,
 TO_DATE('2024-05-20','YYYY-MM-DD'),
 'CCTV footage enhancement and review',
 'Accused identified in footage');

INSERT INTO FORENSIC_REPORT VALUES
(5, 6, 9,
 TO_DATE('2024-03-15','YYYY-MM-DD'),
 'Chemical analysis of seized sample',
 'Substance confirmed as a controlled narcotic');

COMMIT;

-- Check: cases with evidence AND a judgment
SELECT c.case_id, c.case_number, COUNT(DISTINCT e.evidence_id) AS evidence_items,
       COUNT(DISTINCT fr.report_id) AS forensic_reports, MAX(j.verdict) AS verdict
FROM CASE_TABLE c
JOIN EVIDENCE e              ON e.case_id = c.case_id
LEFT JOIN FORENSIC_REPORT fr ON fr.evidence_id = e.evidence_id
LEFT JOIN JUDGMENT j         ON j.case_id = c.case_id
GROUP BY c.case_id, c.case_number
ORDER BY c.case_id;