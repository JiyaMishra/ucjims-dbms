
-- 1. All evidence for a case
SELECT *
FROM EVIDENCE
WHERE case_id = 1;

-- 2. Evidence currently under forensic examination
SELECT *
FROM EVIDENCE
WHERE evidence_status = 'UNDER_EXAMINATION';

-- 3. Complete chain-of-custody history
SELECT *
FROM CHAIN_OF_CUSTODY
WHERE evidence_id = 1
ORDER BY transfer_date;

-- 4. Evidence collected by an investigator
SELECT *
FROM EVIDENCE
WHERE collected_by = 1;

-- 5. Forensic reports for a case
SELECT fr.*
FROM FORENSIC_REPORT fr
JOIN EVIDENCE e ON fr.evidence_id = e.evidence_id
WHERE e.case_id = 1;

-- 6. Evidence status and current storage location
SELECT evidence_id, evidence_type,
       evidence_status, storage_location
FROM EVIDENCE;

-- 7. Audit history of evidence transfers
SELECT *
FROM EVIDENCE_AUDIT
ORDER BY action_time;
