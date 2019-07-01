CREATE table "OBE_EMPLOYEES" (
    "EMPLOYEE_ID" NUMBER(6) NOT NULL,
    "FIRST_NAME"  VARCHAR2(20),
    "LAST_NAME"   VARCHAR2(25),
    "EMAIL"       VARCHAR2(25),
    "HIRE_DATE"   DATE,
    constraint  "OBE_EMPLOYEES_PK" primary key ("EMPLOYEE_ID")
)
/

INSERT INTO obe_employees VALUES ('1','Sue','Littlefield','sue.littlefield','06-FEB-01')
/

INSERT INTO obe_employees VALUES ('2','Mark','Ferris','mark.ferris','05-APR-03')
/

INSERT INTO obe_employees VALUES ('3','Marcie','Young','marcie.young','08-AUG_97')
/

INSERT INTO obe_employees VALUES ('4','Joyce','Bean','joyce.bean','04-APR-00')
/

INSERT INTO obe_employees VALUES ('5','Andrew','Jarvis','andrew,jarvis','01-SEP-99')
/

INSERT INTO obe_employees VALUES ('6','Anthony','Reed','anthony.reed','23-OCT-04')
/

INSERT INTO obe_employees VALUES ('7','Vicki','Dean','vicki.dean','17-DEC-01')
/

INSERT INTO obe_employees VALUES ('8','Emily','Roberts','emily.roberts','03-MAR-02')
/

INSERT INTO obe_employees VALUES ('9','Teressa','Chow','teressa.chow','09-SEP-96')
/


