
-- PERSON B: SAMPLE DATA

-- EVIDENCE
INSERT INTO EVIDENCE VALUES
(1, 1, 'Physical', 'Fingerprint collected from the scene',
 TO_DATE('2026-09-01','YYYY-MM-DD'),
 'Crime Scene A', 1, 'Evidence Room A', 'COLLECTED');

INSERT INTO EVIDENCE VALUES
(2, 1, 'Digital', 'Mobile phone recovered from the scene',
 TO_DATE('2026-09-02','YYYY-MM-DD'),
 'Crime Scene A', 1, 'Forensic Lab 1', 'UNDER_EXAMINATION');

INSERT INTO EVIDENCE VALUES
(3, 2, 'Document', 'Document recovered during investigation',
 TO_DATE('2026-09-03','YYYY-MM-DD'),
 'Office Room B', 2, 'Evidence Room B', 'RETURNED');

-- CHAIN OF CUSTODY
INSERT INTO CHAIN_OF_CUSTODY VALUES
(1, 1, 1, 2,
 TO_DATE('2026-09-01 12:00','YYYY-MM-DD HH24:MI'),
 'Evidence Room A', 'Evidence handover', 'Sealed',
 'Transferred for safe storage');

INSERT INTO CHAIN_OF_CUSTODY VALUES
(2, 2, 1, 3,
 TO_DATE('2026-09-02 14:00','YYYY-MM-DD HH24:MI'),
 'Forensic Lab 1', 'Forensic examination', 'Sealed',
 'Transferred to forensic officer');

INSERT INTO CHAIN_OF_CUSTODY VALUES
(3, 3, 2, 3,
 TO_DATE('2026-09-03 16:00','YYYY-MM-DD HH24:MI'),
 'Evidence Room B', 'Secure storage', 'Good',
 'Evidence handed over securely');

-- FORENSIC REPORT
INSERT INTO FORENSIC_REPORT VALUES
(1, 1, 3,
 TO_DATE('2026-09-04','YYYY-MM-DD'),
 'Fingerprint comparison performed',
 'Comparison completed');

INSERT INTO FORENSIC_REPORT VALUES
(2, 2, 3,
 TO_DATE('2026-09-05','YYYY-MM-DD'),
 'Mobile phone examination started',
 'Examination in progress');

COMMIT;
