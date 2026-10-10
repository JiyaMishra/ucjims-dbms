
-- 10. EVIDENCE
CREATE TABLE EVIDENCE (
    evidence_id         NUMBER PRIMARY KEY,
    case_id             NUMBER NOT NULL,
    evidence_type       VARCHAR2(50) NOT NULL,
    description         VARCHAR2(500),
    collection_date     DATE NOT NULL,
    collection_location VARCHAR2(200),
    collected_by        NUMBER NOT NULL,
    storage_location    VARCHAR2(200),
    evidence_status     VARCHAR2(30) DEFAULT 'COLLECTED'
                            CHECK (evidence_status IN (
                                'COLLECTED',
                                'IN_STORAGE',
                                'UNDER_EXAMINATION',
                                'PRESENTED_IN_COURT',
                                'RELEASED'
                            )),
    CONSTRAINT fk_ev_case FOREIGN KEY (case_id)
        REFERENCES CASE_TABLE(case_id),
    CONSTRAINT fk_ev_user FOREIGN KEY (collected_by)
        REFERENCES APP_USER(user_id)
);


-- 11. CHAIN_OF_CUSTODY
CREATE TABLE CHAIN_OF_CUSTODY (
    custody_id       NUMBER PRIMARY KEY,
    evidence_id      NUMBER NOT NULL,
    transferred_by   NUMBER NOT NULL,
    received_by      NUMBER NOT NULL,
    transfer_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    transfer_location VARCHAR2(200),
    purpose          VARCHAR2(200),
    evidence_condition VARCHAR2(100),
    remarks          VARCHAR2(300),
    CONSTRAINT fk_cc_evidence FOREIGN KEY (evidence_id)
        REFERENCES EVIDENCE(evidence_id),
    CONSTRAINT fk_cc_sender FOREIGN KEY (transferred_by)
        REFERENCES APP_USER(user_id),
    CONSTRAINT fk_cc_receiver FOREIGN KEY (received_by)
        REFERENCES APP_USER(user_id),
    CONSTRAINT chk_cc_users CHECK (transferred_by <> received_by)
);



-- 12. FORENSIC_REPORT
CREATE TABLE FORENSIC_REPORT (
    report_id          NUMBER PRIMARY KEY,
    evidence_id        NUMBER NOT NULL,
    forensic_officer   NUMBER NOT NULL,
    examination_date   DATE NOT NULL,
    examination_details VARCHAR2(500),
    report_result      VARCHAR2(500),
    report_status      VARCHAR2(20) DEFAULT 'PENDING'
                           CHECK (report_status IN (
                               'PENDING',
                               'IN_PROGRESS',
                               'COMPLETED'
                           )),
    CONSTRAINT fk_fr_evidence FOREIGN KEY (evidence_id)
        REFERENCES EVIDENCE(evidence_id),
    CONSTRAINT fk_fr_officer FOREIGN KEY (forensic_officer)
        REFERENCES APP_USER(user_id)
);
