
-- PERSON B: EVIDENCE TRANSFER AUDIT

CREATE TABLE EVIDENCE_AUDIT (
    audit_id           NUMBER PRIMARY KEY,
    custody_id         NUMBER NOT NULL,
    evidence_id        NUMBER NOT NULL,
    action_name        VARCHAR2(50),
    action_time        TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    from_user_id       NUMBER,
    to_user_id         NUMBER,
    transfer_location  VARCHAR2(200),
    remarks            VARCHAR2(300)
);

CREATE SEQUENCE evidence_audit_seq
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_custody_audit
AFTER INSERT ON CHAIN_OF_CUSTODY
FOR EACH ROW
BEGIN
    INSERT INTO EVIDENCE_AUDIT (
        audit_id,
        custody_id,
        evidence_id,
        action_name,
        action_time,
        from_user_id,
        to_user_id,
        transfer_location,
        remarks
    )
    VALUES (
        evidence_audit_seq.NEXTVAL,
        :NEW.custody_id,
        :NEW.evidence_id,
        'EVIDENCE_TRANSFER',
        CURRENT_TIMESTAMP,
        :NEW.from_user_id,
        :NEW.to_user_id,
        :NEW.transfer_location,
        :NEW.remarks
    );
END;
/
