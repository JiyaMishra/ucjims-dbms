
-- PERSON B: EVIDENCE TRANSFER AUDIT

CREATE TABLE EVIDENCE_AUDIT (
    audit_id       NUMBER PRIMARY KEY,
    evidence_id    NUMBER NOT NULL,
    custody_id     NUMBER NOT NULL,
    action_name    VARCHAR2(50),
    action_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    transferred_by NUMBER,
    received_by    NUMBER,
    remarks        VARCHAR2(300)
);

CREATE OR REPLACE TRIGGER trg_custody_audit
AFTER INSERT ON CHAIN_OF_CUSTODY
FOR EACH ROW
BEGIN
    INSERT INTO EVIDENCE_AUDIT (
        audit_id, evidence_id, custody_id, action_name,
        action_time, transferred_by, received_by, remarks
    )
    VALUES (
        (SELECT NVL(MAX(audit_id), 0) + 1
         FROM EVIDENCE_AUDIT),
        :NEW.evidence_id,
        :NEW.custody_id,
        'EVIDENCE_TRANSFER',
        CURRENT_TIMESTAMP,
        :NEW.transferred_by,
        :NEW.received_by,
        :NEW.remarks
    );
END;
/
