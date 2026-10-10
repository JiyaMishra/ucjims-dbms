-- ============================================================
-- UCJIMS - Person C sample data

-- ============================================================

-- COURT
INSERT INTO COURT VALUES (1, 'District Court Hyderabad', 'District', 'Hyderabad', 'Hyderabad District');
INSERT INTO COURT VALUES (2, 'Sessions Court Chennai', 'Sessions', 'Chennai', 'Chennai Sessions Division');
INSERT INTO COURT VALUES (3, 'District Court Pune', 'District', 'Pune', 'Pune District');
INSERT INTO COURT VALUES (4, 'Sessions Court Chandigarh', 'Sessions', 'Chandigarh', 'Chandigarh Sessions Division');

-- LEGAL_PROVISION
INSERT INTO LEGAL_PROVISION VALUES (1, 'Indian Penal Code', '457', 'Lurking house-trespass or house-breaking by night');
INSERT INTO LEGAL_PROVISION VALUES (2, 'Indian Penal Code', '380', 'Theft in a dwelling house');
INSERT INTO LEGAL_PROVISION VALUES (3, 'Indian Penal Code', '384', 'Punishment for extortion');
INSERT INTO LEGAL_PROVISION VALUES (4, 'Narcotic Drugs and Psychotropic Substances Act', '21', 'Contravention in relation to manufactured drugs and preparations');
INSERT INTO LEGAL_PROVISION VALUES (5, 'Indian Penal Code', '420', 'Cheating and dishonestly inducing delivery of property');
INSERT INTO LEGAL_PROVISION VALUES (6, 'Indian Penal Code', '392', 'Punishment for robbery');
INSERT INTO LEGAL_PROVISION VALUES (7, 'Indian Penal Code', '435', 'Mischief by fire with intent to cause damage');
INSERT INTO LEGAL_PROVISION VALUES (8, 'Indian Penal Code', '323', 'Punishment for voluntarily causing hurt');

-- HEARING (judge_id only 4 or 5)
-- Case 4 (closed)
INSERT INTO HEARING VALUES (1, 4, 2, 4, TO_DATE('2024-09-10','YYYY-MM-DD'), 'First Hearing', 'Court Room 2', 'COMPLETED', 'Charges read out; accused pleaded not guilty');
INSERT INTO HEARING VALUES (2, 4, 2, 4, TO_DATE('2025-01-14','YYYY-MM-DD'), 'Cross-Examination', 'Court Room 2', 'COMPLETED', 'Victim cross-examined by defence');
INSERT INTO HEARING VALUES (3, 4, 2, 4, TO_DATE('2025-03-10','YYYY-MM-DD'), 'Judgment Hearing', 'Court Room 2', 'COMPLETED', 'Judgment pronounced');
-- Case 9 (closed)
INSERT INTO HEARING VALUES (4, 9, 3, 5, TO_DATE('2025-02-11','YYYY-MM-DD'), 'First Hearing', 'Court Room 1', 'COMPLETED', 'Charges framed; witness statement recorded');
INSERT INTO HEARING VALUES (5, 9, 3, 5, TO_DATE('2025-05-20','YYYY-MM-DD'), 'Judgment Hearing', 'Court Room 1', 'COMPLETED', 'Judgment pronounced');
-- Case 14 (closed)
INSERT INTO HEARING VALUES (6, 14, 2, 4, TO_DATE('2024-11-05','YYYY-MM-DD'), 'First Hearing', 'Court Room 4', 'COMPLETED', 'Charges framed; bail denied');
INSERT INTO HEARING VALUES (7, 14, 2, 4, TO_DATE('2025-08-12','YYYY-MM-DD'), 'Judgment Hearing', 'Court Room 4', 'COMPLETED', 'Judgment pronounced');
-- Case 3 (under trial)
INSERT INTO HEARING VALUES (8, 3, 1, 5, TO_DATE('2025-06-18','YYYY-MM-DD'), 'First Hearing', 'Court Room 3', 'COMPLETED', 'Charges framed; documents submitted');
INSERT INTO HEARING VALUES (9, 3, 1, 5, TO_DATE('2026-09-22','YYYY-MM-DD'), 'Cross-Examination', 'Court Room 3', 'ADJOURNED', 'Adjourned at request of defence counsel');
INSERT INTO HEARING VALUES (10, 3, 1, 5, TO_DATE('2026-10-28','YYYY-MM-DD'), 'Cross-Examination', 'Court Room 3', 'SCHEDULED', NULL);
-- Case 8 (under trial)
INSERT INTO HEARING VALUES (14, 8, 4, 4, TO_DATE('2026-03-17','YYYY-MM-DD'), 'First Hearing', 'Court Room 5', 'COMPLETED', 'Charges framed; trial date fixed');
INSERT INTO HEARING VALUES (11, 8, 4, 4, TO_DATE('2026-10-20','YYYY-MM-DD'), 'Evidence Hearing', 'Court Room 5', 'SCHEDULED', NULL);
-- Case 13 (under trial)
INSERT INTO HEARING VALUES (15, 13, 1, 5, TO_DATE('2026-05-12','YYYY-MM-DD'), 'First Hearing', 'Court Room 2', 'COMPLETED', 'Charges framed; next date fixed');
INSERT INTO HEARING VALUES (12, 13, 1, 5, TO_DATE('2026-11-05','YYYY-MM-DD'), 'Evidence Hearing', 'Court Room 2', 'SCHEDULED', NULL);
-- Case 2 (chargesheeted)
INSERT INTO HEARING VALUES (13, 2, 1, 5, TO_DATE('2026-11-18','YYYY-MM-DD'), 'Charge Framing', 'Court Room 3', 'SCHEDULED', NULL);

-- HEARING_PARTICIPANT (persons taken from CASE_PERSON of the same case)
INSERT INTO HEARING_PARTICIPANT VALUES (1, 1, 40, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (2, 1, 34, 'WITNESS');
INSERT INTO HEARING_PARTICIPANT VALUES (3, 2, 40, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (4, 2, 34, 'WITNESS');
INSERT INTO HEARING_PARTICIPANT VALUES (5, 3, 40, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (6, 4, 3, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (7, 4, 22, 'WITNESS');
INSERT INTO HEARING_PARTICIPANT VALUES (8, 5, 3, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (9, 6, 3, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (10, 6, 23, 'WITNESS');
INSERT INTO HEARING_PARTICIPANT VALUES (11, 7, 3, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (12, 8, 11, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (13, 8, 29, 'WITNESS');
INSERT INTO HEARING_PARTICIPANT VALUES (14, 9, 11, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (15, 9, 29, 'WITNESS');
INSERT INTO HEARING_PARTICIPANT VALUES (16, 10, 11, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (17, 14, 6, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (18, 11, 6, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (19, 11, 28, 'WITNESS');
INSERT INTO HEARING_PARTICIPANT VALUES (20, 15, 3, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (21, 15, 20, 'WITNESS');
INSERT INTO HEARING_PARTICIPANT VALUES (22, 12, 3, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (23, 13, 17, 'ACCUSED');
INSERT INTO HEARING_PARTICIPANT VALUES (24, 13, 9, 'WITNESS');

-- JUDGMENT (closed cases only)
INSERT INTO JUDGMENT VALUES (1, 4, TO_DATE('2025-03-10','YYYY-MM-DD'), 'Guilty', 'Accused found guilty of house-breaking and theft; sentenced to imprisonment');
INSERT INTO JUDGMENT VALUES (2, 9, TO_DATE('2025-05-20','YYYY-MM-DD'), 'Guilty', 'Accused found guilty of extortion; monetary fine imposed');
INSERT INTO JUDGMENT VALUES (3, 14, TO_DATE('2025-08-12','YYYY-MM-DD'), 'Guilty', 'Accused found guilty of drug trafficking; imprisonment and fine imposed');

-- CASE_PROVISION
INSERT INTO CASE_PROVISION VALUES (1, 4, 1);
INSERT INTO CASE_PROVISION VALUES (2, 4, 2);
INSERT INTO CASE_PROVISION VALUES (3, 9, 3);
INSERT INTO CASE_PROVISION VALUES (4, 14, 4);
INSERT INTO CASE_PROVISION VALUES (5, 3, 5);
INSERT INTO CASE_PROVISION VALUES (6, 8, 6);
INSERT INTO CASE_PROVISION VALUES (7, 13, 7);
INSERT INTO CASE_PROVISION VALUES (8, 2, 8);

-- SENTENCE (only ACCUSED persons of the judged cases)
INSERT INTO SENTENCE VALUES (1, 1, 40, 'Imprisonment', '20 months', NULL, TO_DATE('2025-03-10','YYYY-MM-DD'), TO_DATE('2026-11-10','YYYY-MM-DD'));
INSERT INTO SENTENCE VALUES (2, 2, 3, 'Fine', NULL, 50000, TO_DATE('2025-05-20','YYYY-MM-DD'), NULL);
INSERT INTO SENTENCE VALUES (3, 3, 3, 'Both', '10 years', 100000, TO_DATE('2025-08-12','YYYY-MM-DD'), TO_DATE('2035-08-12','YYYY-MM-DD'));

-- PRISON
INSERT INTO PRISON VALUES (1, 'Central Prison Hyderabad', 'Hyderabad', 800);
INSERT INTO PRISON VALUES (2, 'Chennai Central Prison', 'Chennai', 1200);
INSERT INTO PRISON VALUES (3, 'District Jail Pune', 'Pune', 400);

-- INMATE (only imprisonment sentences; prison_id = CURRENT prison)
INSERT INTO INMATE VALUES (1, 40, 3, 1, TO_DATE('2025-03-12','YYYY-MM-DD'), TO_DATE('2026-11-10','YYYY-MM-DD'), NULL, 'INCARCERATED');
INSERT INTO INMATE VALUES (2, 3, 2, 3, TO_DATE('2025-08-14','YYYY-MM-DD'), TO_DATE('2035-08-12','YYYY-MM-DD'), NULL, 'INCARCERATED');

-- PRISON_TRANSFER (both inmates were first admitted to prison 1)
INSERT INTO PRISON_TRANSFER VALUES (1, 1, 1, 3, TO_DATE('2026-03-05','YYYY-MM-DD'), 'Overcrowding at origin prison');
INSERT INTO PRISON_TRANSFER VALUES (2, 2, 1, 2, TO_DATE('2026-02-10','YYYY-MM-DD'), 'Transferred to long-term facility');

COMMIT;

-- Quick check: row counts
SELECT 'COURT' AS table_name, COUNT(*) AS row_count FROM COURT
UNION ALL SELECT 'HEARING', COUNT(*) FROM HEARING
UNION ALL SELECT 'HEARING_PARTICIPANT', COUNT(*) FROM HEARING_PARTICIPANT
UNION ALL SELECT 'JUDGMENT', COUNT(*) FROM JUDGMENT
UNION ALL SELECT 'LEGAL_PROVISION', COUNT(*) FROM LEGAL_PROVISION
UNION ALL SELECT 'CASE_PROVISION', COUNT(*) FROM CASE_PROVISION
UNION ALL SELECT 'SENTENCE', COUNT(*) FROM SENTENCE
UNION ALL SELECT 'PRISON', COUNT(*) FROM PRISON
UNION ALL SELECT 'INMATE', COUNT(*) FROM INMATE
UNION ALL SELECT 'PRISON_TRANSFER', COUNT(*) FROM PRISON_TRANSFER;