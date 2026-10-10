
-- PERSON B: EVIDENCE AND FORENSICS TABLES

-- 10. EVIDENCE
CREATE TABLE EVIDENCE (
    evidence_id         NUMBER PRIMARY KEY,
    case_id             NUMBER NOT NULL,
    evidence_type       VARCHAR2(50),
    description         VARCHAR2(500),
    collection_date     DATE NOT NULL,
    collection_location VARCHAR2(200),
    collected_by        NUMBER,
    storage_location    VARCHAR2(200),
    current_status      VARCHAR2(30)
                            CHECK (current_status IN (
                                'COLLECTED',
                                'UNDER_EXAMINATION',
                                'RETURNED',
                                'DISPOSED'
                            )),
    CONSTRAINT fk_ev_case FOREIGN KEY (case_id)
        REFERENCES CASE_TABLE(case_id),
    CONSTRAINT fk_ev_user FOREIGN KEY (collected_by)
        REFERENCES APP_USER(user_id)
);

-- 11. CHAIN_OF_CUSTODY
CREATE TABLE CHAIN_OF_CUSTODY (
    custody_id          NUMBER PRIMARY KEY,
    evidence_id         NUMBER NOT NULL,
    from_user_id        NUMBER,
    to_user_id          NUMBER,
    transfer_date_time  DATE NOT NULL,
    transfer_location   VARCHAR2(200),
    purpose             VARCHAR2(200),
    condition           VARCHAR2(100),
    remarks             VARCHAR2(300),
    CONSTRAINT fk_cc_evidence FOREIGN KEY (evidence_id)
        REFERENCES EVIDENCE(evidence_id),
    CONSTRAINT fk_cc_from_user FOREIGN KEY (from_user_id)
        REFERENCES APP_USER(user_id),
    CONSTRAINT fk_cc_to_user FOREIGN KEY (to_user_id)
        REFERENCES APP_USER(user_id)
);

-- 12. FORENSIC_REPORT
CREATE TABLE FORENSIC_REPORT (
    report_id            NUMBER PRIMARY KEY,
    evidence_id          NUMBER NOT NULL,
    forensic_officer_id  NUMBER,
    examination_date     DATE NOT NULL,
    examination_details  VARCHAR2(500),
    result               VARCHAR2(300),
    CONSTRAINT fk_fr_evidence FOREIGN KEY (evidence_id)
        REFERENCES EVIDENCE(evidence_id),
    CONSTRAINT fk_fr_officer FOREIGN KEY (forensic_officer_id)
        REFERENCES APP_USER(user_id)
);
