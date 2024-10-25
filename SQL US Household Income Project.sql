
#Cleaning US Household

SELECT * FROM us_schema.us_household_income;

SELECT * FROM us_schema.us_householdincome_statistics; 

#This query is designed to rename a column in the us_householdincome_statistics table from 'ï»¿id' to 'id'.
ALTER TABLE us_schema.us_householdincome_statistics 
RENAME COLUMN `ï»¿id` TO `id`;

#The query aims to count the number of rows in the us_household_income table in the us_schema schema by counting non-NULL values in the id column.
SELECT COUNT(id)
FROM us_schema.us_household_income; 

#The query is correctly structured to count the non-NULL entries in the id column of the us_householdincome_statistics table within the us_schema schema.
SELECT COUNT(id)
 FROM us_schema.us_householdincome_statistics;   
 
#The query is designed to find duplicate id values in the us_household_income table by grouping rows based on id and filtering for those with a count greater than 1. 
 SELECT id, COUNT(id)
FROM us_schema.us_household_income 
group by id 
HAVING count(id) > 1; 


#The query attempts to delete duplicate rows in the us_schema.us_household_income table by retaining only the first occurrence of each unique id.
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
 
 
#The query will give a list of each state along with the count of records associated with it. 
 SELECT State_Name, COUNT(STATE_Name)
 FROM us_schema.us_household_income 
 GROUP BY State_Name; 
 
#The query is structured correctly and will update any rows where State_Name is mistakenly set to 'georia'
UPDATE us_schema.us_household_income 
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';  

# The query correctly updates any rows in the us_schema.us_household_income table where State_Name is incorrectly set to lowercase 'alabama'
UPDATE us_schema.us_household_income 
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';   

# The query aims to update the Place field in the us_schema.us_household_income table to 'Autaugaville' for records where the County is 'Autauga County' and the City is 'Vinemont'.
UPDATE us_schema.us_household_income 
SET Place = 'Autaugaville'
WHERE County = 'Autauga County' 
AND City = 'Vinemont'; 

#This query will output each unique Type along with its count in the table. Let me know if you need further assistance!
SELECT Type, COUNT(Type) 
FROM us_schema.us_household_income;  

#Your query is designed to select records from the us_schema.us_household_income table where both AWater and ALand are either zero, empty, or NULL. 
SELECT ALand, AWater 
FROM us_schema.us_household_income 
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL) 
AND (ALand = 0 OR ALand = '' OR ALand IS NULL); 


#EXPLORATORY Data Analysis on US Households 

SELECT * 
 FROM us_schema.us_household_income; 
 

SELECT * FROM us_schema.us_householdincome_statistics;   

#The query is structured to return the total land (ALand) and water (AWater) area for each state, ordered by the sum of AWater in descending order. 
SELECT State_Name, SUM(ALand), SUM(AWater)
 FROM us_schema.us_household_income 
 GROUP BY State_Name 
 ORDER BY 3  DESC; 
 
#The query joins two tables, us_household_income and us_householdincome_statistics, to calculate the average Mean and Median for each State_Name. 
 SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
 FROM us_schema.us_household_income u
 INNER JOIN us_schema.us_householdincome_statistics us
 ON u.id = us.id 
  WHERE Mean <> 0
 GROUP BY u.State_Name;

 
 
 
 
 
 
 
 
 
 











 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 