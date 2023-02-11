-- SCRIPT TO CREATE tables for our APP01 DB
DROP TABLE STUDENT;
DROP TABLE GRADE_REPORT;
DROP TABLE CLSECTION;
DROP TABLE DEPARTMENT_TO_MAJOR;
DROP TABLE PREREQ;
DROP TABLE COURSE;
DROP TABLE CAP;
DROP TABLE ROOM;
DROP TABLE DEPENDENT;
DROP TABLE PLANTS;

CREATE TABLE STUDENT(
    STNO SMALLINT PRIMARY KEY NOT NULL, 
	SNAME VARCHAR2(20) NULL,
	MAJOR VARCHAR2(4) NULL,
	CLASS SMALLINT NULL,
	BDATE DATE NULL
) TABLESPACE APP01;

CREATE TABLE GRADE_REPORT(
    STUDENT_NUMBER SMALLINT NOT NULL, 
	SECTION_ID SMALLINT NOT NULL,
	GRADE CHAR(1),
	CONSTRAINT STNO_SECID PRIMARY KEY (STUDENT_NUMBER, SECTION_ID)
) TABLESPACE APP01;

CREATE TABLE CLSECTION(
    SECTION_ID SMALLINT PRIMARY KEY NOT NULL, 
	COURSE_NUM VARCHAR2(8),
	SEMESTER VARCHAR2(6),
	YEAR CHAR(2),
	INSTRUCTOR VARCHAR2(10),
	BLDG SMALLINT,
	ROOM SMALLINT
) TABLESPACE APP01;

CREATE TABLE DEPARTMENT_TO_MAJOR(
    DCODE VARCHAR2(4) PRIMARY KEY NOT NULL,
	DNAME VARCHAR2(20)
) TABLESPACE APP01;

CREATE TABLE PLANTS(
    COMPANY VARCHAR2(20),
	PLANTLO VARCHAR2(15)
) TABLESPACE APP01;

CREATE TABLE PREREQ(
    COURSE_NUMBER VARCHAR2(8) NOT NULL,
	PREREQ VARCHAR2(8) NOT NULL,
	CONSTRAINT COUNO_PRE PRIMARY KEY(COURSE_NUMBER, PREREQ)
) TABLESPACE APP01;

CREATE TABLE COURSE(
    COURSE_NAME VARCHAR2(20),
	COURSE_NUMBER VARCHAR2(8) PRIMARY KEY NOT NULL,
	CREDIT_HOURS SMALLINT,
	OFFERING_DEPT VARCHAR2(4)
) TABLESPACE APP01;

CREATE TABLE CAP(
    NAME VARCHAR2(9),
	LANGU VARCHAR2(7)
) TABLESPACE APP01;

CREATE TABLE ROOM(
    BLDG SMALLINT NOT NULL,
	ROOM SMALLINT NOT NULL,
	CAPACITY SMALLINT,
	OHEAD VARCHAR2(1),
	CONSTRAINT bldg_room PRIMARY KEY(BLDG, ROOM)
) TABLESPACE APP01;

CREATE TABLE DEPENDENT(
    PNO SMALLINT NOT NULL,
	DNAME VARCHAR2(20) NULL,
	RELATIONSHIP VARCHAR2(8) NULL,
	GENDER CHAR(1) NULL,
	AGE SMALLINT NULL
) TABLESPACE APP01;

commit;
quit;