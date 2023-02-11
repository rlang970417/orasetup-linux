-- SCRIPT TO GRANT access to our users

GRANT SELECT on STUDENT to reporter;
GRANT SELECT on GRADE_REPORT to reporter;
GRANT SELECT on CLSECTION to reporter;
GRANT SELECT on DEPARTMENT_TO_MAJOR to reporter;
GRANT SELECT on PLANTS to reporter;
GRANT SELECT on PREREQ to reporter;
GRANT SELECT on COURSE to reporter;
GRANT SELECT on CAP to reporter;
GRANT SELECT on ROOM to reporter;
GRANT SELECT on DEPENDENT to reporter;

GRANT SELECT on STUDENT to appdba;
GRANT SELECT on GRADE_REPORT to appdba;
GRANT SELECT on CLSECTION to appdba;
GRANT SELECT on DEPARTMENT_TO_MAJOR to appdba;
GRANT SELECT on PLANTS to appdba;
GRANT SELECT on PREREQ to appdba;
GRANT SELECT on COURSE to appdba;
GRANT SELECT on CAP to appdba;
GRANT SELECT on ROOM to appdba;
GRANT SELECT on DEPENDENT to appdba;

GRANT INSERT on STUDENT to appdba;
GRANT INSERT on GRADE_REPORT to appdba;
GRANT INSERT on CLSECTION to appdba;
GRANT INSERT on DEPARTMENT_TO_MAJOR to appdba;
GRANT INSERT on PLANTS to appdba;
GRANT INSERT on PREREQ to appdba;
GRANT INSERT on COURSE to appdba;
GRANT INSERT on CAP to appdba;
GRANT INSERT on ROOM to appdba;
GRANT INSERT on DEPENDENT to appdba;

GRANT UPDATE on STUDENT to appdba;
GRANT UPDATE on GRADE_REPORT to appdba;
GRANT UPDATE on CLSECTION to appdba;
GRANT UPDATE on DEPARTMENT_TO_MAJOR to appdba;
GRANT UPDATE on PLANTS to appdba;
GRANT UPDATE on PREREQ to appdba;
GRANT UPDATE on COURSE to appdba;
GRANT UPDATE on CAP to appdba;
GRANT UPDATE on ROOM to appdba;
GRANT UPDATE on DEPENDENT to appdba;

GRANT DELETE on STUDENT to appdba;
GRANT DELETE on GRADE_REPORT to appdba;
GRANT DELETE on CLSECTION to appdba;
GRANT DELETE on DEPARTMENT_TO_MAJOR to appdba;
GRANT DELETE on PLANTS to appdba;
GRANT DELETE on PREREQ to appdba;
GRANT DELETE on COURSE to appdba;
GRANT DELETE on CAP to appdba;
GRANT DELETE on ROOM to appdba;
GRANT DELETE on DEPENDENT to appdba;

commit;
quit;