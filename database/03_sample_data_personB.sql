
-- PERSON B: SAMPLE DATA
-- Parent records must exist before running these inserts.

INSERT INTO EVIDENCE VALUES
(1, 1, 'FINGERPRINT', 'Fingerprint lifted from the scene',
 TO_DATE('2026-09-01','YYYY-MM-DD'), 'Crime Scene A', 1,
 'Evidence Room A', 'IN_STORAGE');

INSERT INTO EVIDENCE VALUES
(2, 1, 'MOBILE_PHONE', 'Mobile phone recovered at the scene',
 TO_DATE('2026-09-02','YYYY-MM-DD'), 'Crime Scene A', 1,
 'Forensic Lab 1', 'UNDER_EXAMINATION');

INSERT INTO EVIDENCE VALUES
(3, 2, 'CCTV_FOOTAGE', 'CCTV footage collected from nearby shop',
 TO_DATE('2026-09-03','YYYY-MM-DD'), 'Shop CCTV Room', 2,
 'Evidence Room B', 'COLLECTED');

INSERT INTO CHAIN_OF_CUSTODY VALUES
(1, 1, 1, 2, TIMESTAMP '2026-09-01 12:00:00',
 'Evidence Room A', 'Storage', 'Sealed', 'Evidence received');

INSERT INTO CHAIN_OF_CUSTODY VALUES
(2, 2, 1, 3, TIMESTAMP '2026-09-02 14:00:00',
 'Forensic Lab 1', 'Forensic examination', 'Sealed',
 'Transferred to forensic officer');

INSERT INTO CHAIN_OF_CUSTODY VALUES
(3, 3, 2, 3, TIMESTAMP '2026-09-03 16:00:00',
 'Evidence Room B', 'Secure storage', 'Good',
 'Evidence stored securely');

INSERT INTO FORENSIC_REPORT VALUES
(1, 1, 3, TO_DATE('2026-09-04','YYYY-MM-DD'),
 'Fingerprint comparison performed',
 'Fingerprint comparison completed',
 'COMPLETED');

INSERT INTO FORENSIC_REPORT VALUES
(2, 2, 3, TO_DATE('2026-09-05','YYYY-MM-DD'),
 'Mobile device examination started',
 NULL, 'IN_PROGRESS');

COMMIT;
