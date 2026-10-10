-- ============================================================
-- UCJIMS - Person C: Court, Judgment, Sentence & Prison module
-- ============================================================


CREATE TABLE COURT (
  court_id      NUMBER PRIMARY KEY,
  court_name    VARCHAR2(100) NOT NULL,
  court_type    VARCHAR2(50),
  location      VARCHAR2(100),
  jurisdiction  VARCHAR2(100)
);

CREATE TABLE HEARING (
  hearing_id      NUMBER PRIMARY KEY,
  case_id         NUMBER NOT NULL REFERENCES CASE_TABLE(case_id),
  court_id        NUMBER REFERENCES COURT(court_id),
  judge_id        NUMBER REFERENCES APP_USER(user_id),
  hearing_date    DATE NOT NULL,
  hearing_type    VARCHAR2(50),
  courtroom       VARCHAR2(30),
  hearing_status  VARCHAR2(30),
  proceedings     VARCHAR2(500),
  CONSTRAINT chk_hearing_status
    CHECK (hearing_status IN ('SCHEDULED','COMPLETED','ADJOURNED'))
);

CREATE TABLE HEARING_PARTICIPANT (
  hearing_participant_id  NUMBER PRIMARY KEY,
  hearing_id              NUMBER NOT NULL REFERENCES HEARING(hearing_id),
  person_id               NUMBER NOT NULL REFERENCES PERSON(person_id),
  participant_role        VARCHAR2(30),
  CONSTRAINT chk_participant_role
    CHECK (participant_role IN ('ACCUSED','WITNESS','LAWYER','PROSECUTOR')),
  CONSTRAINT uq_hearing_person UNIQUE (hearing_id, person_id)
);

CREATE TABLE JUDGMENT (
  judgment_id       NUMBER PRIMARY KEY,
  case_id           NUMBER NOT NULL REFERENCES CASE_TABLE(case_id),
  judgment_date     DATE NOT NULL,
  verdict           VARCHAR2(50),
  judgment_summary  VARCHAR2(500)
);

CREATE TABLE LEGAL_PROVISION (
  provision_id    NUMBER PRIMARY KEY,
  act_name        VARCHAR2(100) NOT NULL,
  section_number  VARCHAR2(20) NOT NULL,
  description     VARCHAR2(300)
);

CREATE TABLE CASE_PROVISION (
  case_provision_id  NUMBER PRIMARY KEY,
  case_id            NUMBER NOT NULL REFERENCES CASE_TABLE(case_id),
  provision_id       NUMBER NOT NULL REFERENCES LEGAL_PROVISION(provision_id),
  CONSTRAINT uq_case_provision UNIQUE (case_id, provision_id)
);

CREATE TABLE SENTENCE (
  sentence_id    NUMBER PRIMARY KEY,
  judgment_id    NUMBER NOT NULL REFERENCES JUDGMENT(judgment_id),
  person_id      NUMBER NOT NULL REFERENCES PERSON(person_id),
  sentence_type  VARCHAR2(50),
  duration       VARCHAR2(50),
  fine_amount    NUMBER,
  start_date     DATE,
  end_date       DATE,
  CONSTRAINT chk_sentence_dates
    CHECK (start_date IS NULL OR end_date IS NULL OR end_date >= start_date),
  CONSTRAINT chk_sentence_fine CHECK (fine_amount IS NULL OR fine_amount >= 0)
);

CREATE TABLE PRISON (
  prison_id    NUMBER PRIMARY KEY,
  prison_name  VARCHAR2(100) NOT NULL,
  location     VARCHAR2(100),
  capacity     NUMBER,
  CONSTRAINT chk_prison_capacity CHECK (capacity IS NULL OR capacity > 0)
);

CREATE TABLE INMATE (
  inmate_id              NUMBER PRIMARY KEY,
  person_id              NUMBER NOT NULL REFERENCES PERSON(person_id),
  prison_id              NUMBER NOT NULL REFERENCES PRISON(prison_id),  -- current prison
  sentence_id            NUMBER REFERENCES SENTENCE(sentence_id),
  admission_date         DATE NOT NULL,
  expected_release_date  DATE,
  actual_release_date    DATE,
  status                 VARCHAR2(30),
  CONSTRAINT chk_inmate_status
    CHECK (status IN ('INCARCERATED','RELEASED','PAROLED')),
  CONSTRAINT chk_inmate_release
    CHECK (expected_release_date IS NULL OR expected_release_date >= admission_date)
);

CREATE TABLE PRISON_TRANSFER (
  transfer_id     NUMBER PRIMARY KEY,
  inmate_id       NUMBER NOT NULL REFERENCES INMATE(inmate_id),
  from_prison_id  NUMBER REFERENCES PRISON(prison_id),
  to_prison_id    NUMBER REFERENCES PRISON(prison_id),
  transfer_date   DATE NOT NULL,
  reason          VARCHAR2(200),
  CONSTRAINT chk_transfer_diff_prison CHECK (from_prison_id <> to_prison_id)
);