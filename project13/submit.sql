Database are stored separately as 3 tables under submit_** sql files:
  submit_ChicagoCensusData.csv (CENSUS table)
  submit_ChicagoCrimeData.csv (CRIME table)
  submit_ChicagoPublicSchools.csv (SCHOOL table)
--1.1.Write and execute a SQL query to list the school names, community names and average attendance for communities with a hardship index of 98. 
select s.NAME_OF_SCHOOL, s.AVERAGE_STUDENT_ATTENDANCE, 
  c.COMMNITY_AREA_NAME, c.HARDSHIP_INDEX from CENSUS c, SCHOOL s
  where s.COMMUNITY_AREA_NUMBER = c.COMMUNITY_AREA_NUMBER
  and c.HARDSHIP_INDEX=98  
--1.2.Write and execute a SQL query to list all crimes that took place at a school. Include case number, crime type and community name.
select c.CASE_NUMBER, c.PRIMARY_TYPE, 
  s.COMMUNITY_AREA_NAME from CRIME c, CENSUS s
  where c.LOCATION_DESCRIPTION like '%SCHOOL%'
  and c.COMMUNITY_AREA_NUMBER = s.COMMUNITY_AREA_NUMBER
--2.1.Write and execute a SQL statement that returns just the school name and leaders’ icon from the view. 
create view school_info as
  select s.name_of_school as school_name,
    s.safety_icon as safety_rating,
    s.family_involvementt_icon as family_rating,
    s.environment_icon as instruction_rating,
    s.instruction_icon as leaders_rating,
    s.leaders_icon as leaders_rating,
    s.teachers_icon as teachers_rating
  from SCHOOL s;
select school_name, leaders_rating from school_info;
--3.Write the structure of a query to create or replace a stored procedure called UPDATE_LEADERS_SCORE that takes a in_School_ID parameter as an integer and a in_Leader_Score parameter as an integer. Don't forget to use the #SET TERMINATOR statement to use the @ for the CREATE statement terminator. 
--with IF statement base on range of Leader Score [0,20), [20,40), [40,60), [60,80), [80,100) as VeryWeak, Weak, Average, Strong, Very Strong
--4.1.Update your stored procedure definition. Add a generic ELSE clause to the IF statement that rolls back the current work if the score did not fit any of the preceding categories. 
--4.2.Update your stored procedure definition again. Add a statement to commit the current unit of work at the end of the procedure. 
--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE (IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)
LANGUAGE SQL MODIFIES SQL DATA
BEGIN
 UPDATE SCHOOL SET LEADERS_SCORE = in_Leader_Score WHERE SCHOOL_ID = in_School_ID;
 IF in_Leader_Score > 0 AND in_Leader_Score < 20 THEN UPDATE SCHOOL SET LEADERS_ICON = 'VWEAK' WHERE SCHOOL_ID = in_School_ID;
 ELSEIF in_Leader_Score < 40 THEN UPDATE SCHOOL SET LEADERS_ICON = 'WEAK' WHERE SCHOOL_ID = in_School_ID;
 ELSEIF in_Leader_Score  < 60 THEN UPDATE SCHOOL SET LEADERS_ICON = 'AVRG' WHERE SCHOOL_ID = in_School_ID;
 ELSEIF in_Leader_Score  < 80 THEN UPDATE SCHOOL SET LEADERS_ICON = 'STROG' WHERE SCHOOL_ID = in_School_ID;
 ELSEIF in_Leader_Score  < 100 THEN UPDATE SCHOOL SET LEADERS_ICON = 'VSTRG' WHERE SCHOOL_ID = in_School_ID;
 ELSE UPDATE SCHOOL SET LEADERS_ICON = LEADERS_ICON WHERE SCHOOL_ID = in_School_ID;
 END IF;
 COMMIT;
END
@
CALL UPDATE_LEADERS_SCORE(610038, 50) @ --Update school leader icon with school id
SELECT SCHOOL_ID, LEADERS_SCORE, LEADERS_ICON FROM SCHOOL WHERE SCHOOL_ID = 610038 --Check out result
