
#Cleaning US Household

SELECT * FROM us_schema.us_household_income;

SELECT * FROM us_schema.us_householdincome_statistics; 


ALTER TABLE us_schema.us_householdincome_statistics RENAME COLUMN `ï»¿id` TO `id`; 

SELECT COUNT(id)
FROM us_schema.us_household_income; 

SELECT COUNT(id)
 FROM us_schema.us_householdincome_statistics;   
 
 
 SELECT id, COUNT(id)
FROM us_schema.us_household_income 
group by id 
HAVING count(id) > 1; 

DELETE FROM us.household_income
WHERE row_id IN (
SELECT row_id
FROM
(SELECT row_id, 
id, 
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_schema.us_household_income) duplicates 
WHERE row_num > 1);
 
 
 
 SELECT * 
 FROM us_schema.us_household_income; 
 
 
 
 SELECT State_Name, COUNT(STATE_Name)
 FROM us_schema.us_household_income 
 GROUP BY State_Name; 
 
UPDATE us_schema.us_household_income 
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';  

UPDATE us_schema.us_household_income 
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';   


UPDATE us_schema.us_household_income 
SET Place = 'Autaugaville'
WHERE County = 'Autauga County' 
AND City = 'Vinemont'; 


SELECT Type, COUNT(Type) 
FROM us_schema.us_household_income;  

SELECT ALand, AWater 
FROM us_schema.us_household_income 
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL) 
AND (ALand = 0 OR ALand = '' OR ALand IS NULL); 


#eXPLORATORY Data Analysis on US Households 

SELECT * 
 FROM us_schema.us_household_income; 
 

SELECT * FROM us_schema.us_householdincome_statistics;   


SELECT State_Name, SUM(ALand), SUM(AWater)
 FROM us_schema.us_household_income 
 GROUP BY State_Name 
 ORDER BY 3  DESC; 
 
 SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
 FROM us_schema.us_household_income u
 INNER JOIN us_schema.us_householdincome_statistics us
 ON u.id = us.id 
  WHERE Mean <> 0
 GROUP BY u.State_Name;

 
 
 
 
 
 
 
 
 
 











 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 