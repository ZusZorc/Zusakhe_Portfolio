# WOrld Life Expectancy

#The query below was to observe the data on Life Expectancy
SELECT * FROM world_life_expectancy.world_life_expectancy; 


#This query is to check for the countries and years that have more than one entry in the table
SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy 
GROUP  BY Country, Year, CONCAT(Country, Year) 
HAVING COUNT(CONCAT(Country, Year)) >1; 

# This query will give the duplicates based off the country and year
SELECT *
FROM
(SELECT Row_ID, 
CONCAT(Country, Year), 
ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num 
from world_life_expectancy) AS Row_Table 
WHERE Row_Num > 1; 


#This query serves to delete the duplicates
DELETE FROM world_life_expectancy 
WHERE 
Row_ID IN (
SELECT Row_ID
FROM
(SELECT Row_ID, 
CONCAT(Country, Year), 
ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num 
from world_life_expectancy) AS Row_Table 
WHERE Row_Num > 1);  


#This query gives the count of duplicates that occur for country and year
SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy 
GROUP  BY Country, Year, CONCAT(Country, Year) 
HAVING COUNT(CONCAT(Country, Year)) >1; 


SELECT * FROM world_life_expectancy.world_life_expectancy;  

#This query will pull the rows where there are empty cells under the Status column
SELECT * 
FROM world_life_expectancy 
WHERE Status = ''; 

#This query only selects the distinct values of the status column
SELECT DISTINCT(Status) 
FROM world_life_expectancy
WHERE Status <> '';

#This query selects the distinct values in the country column where the status is "Developing"
SELECT DISTINCT(Country) 
FROM world_life_expectancy 
WHERE Status = 'Developing'; 


#This query serves to update all the "Developing" countries in the Status column all have the same status name of "Developing".
UPDATE world_life_expectancy
SET Status = 'Developing' 
WHERE Country IN (SELECT DISTINCT(Country) 
              FROM world_life_expectancy 
			 WHERE Status = 'Developing'); 


#This query will set the Status to 'Developing' for rows with an empty Status, but only for countries where another row already has the status 'Developing'.             
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2 
ON t1.Country = t2.Country
SET t1.Status = 'Developing' 
WHERE T1.Status = '' 
AND t2.Status <> '' 
AND t2.Status = 'Developing';  

#This query selects the table world life expectancy where the country column has United States of America
SELECT * 
FROM world_life_expectancy 
WHERE Country = 'United States of America'; 

#This query aims to update the Status of rows with an empty status to "Developed"
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2 
ON t1.Country = t2.Country
SET t1.Status = 'Developed' 
WHERE T1.Status = '' 
AND t2.Status <> '' 
AND t2.Status = 'Developed'; 

#This query selects the rows where the Status is blank
SELECT * 
FROM world_life_expectancy 
WHERE Status = ''; 


#This query selects the country, year and life expectancy columns where there are blanks in life expectancy

SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
WHERE `Life expectancy` =  ''; 


#The query selects records from the world_life_expectancy table where the Life expectancy column is empty ('') for a specific year, and calculates the average life expectancy using the previous and next year’s data for the same country.
SELECT t1.Country, t1.Year, t1.`Life expectancy`, t2.Country, t2.Year, t2.`Life expectancy`, t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy`+ t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2 
ON t1.Country = t2.Country 
AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
ON t1.Country = t3.Country 
AND t1.Year = t3.Year + 1 
WHERE t1.`Life expectancy` = ''; 


#The query is designed to update rows in the world_life_expectancy table by setting the Life expectancy value to the average of the previous and next years' Life expectancy values for the same country, where the current Life expectancy is empty ('').
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2 
ON t1.Country = t2.Country 
AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
ON t1.Country = t3.Country 
AND t1.Year = t3.Year + 1 
SET t1.`life expectancy` = ROUND((t2.`Life expectancy`+ t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = '';

#This query selects the country, year and life expectancy columns where there are blanks in life expectancy
SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
WHERE `Life expectancy` =  ''; 


#Exploratory Data Analysis 


#The query will give you the minimum and maximum life expectancy for each country, along with the increase in life expectancy over time, excluding records where life expectancy is zero.
SELECT Country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`), 
ROUND (MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy 
GROUP BY Country 
HAVING MIN(`Life expectancy`) <> 0 
AND    MAX(`Life expectancy`) <> 0 
ORDER BY Country DESC; 

#This query will produce the average life expectancy for each year, rounded to two decimal places, while excluding entries with zero life expectancy.
SELECT Year, ROUND (AVG(`Life expectancy`),2)
FROM world_life_expectancy 
WHERE `Life expectancy` <> 0
GROUP BY Year 
ORDER BY Year;


SELECT*
FROM world_life_expectancy; 



#This will return each country's average life expectancy and GDP, excluding entries where either metric averages to zero or below, ordered by GDP from highest to lowest. 
SELECT Country, ROUND(AVG(`LIfe expectancy`),1) AS Life_Exp, ROUND (AVG(GDP),1) AS GDP
FROM world_life_expectancy 
GROUP BY Country 
HAVING Life_Exp > 0 
AND GDP > 0
ORDER BY GDP DESC;  



#This query will return the count of high-GDP and low-GDP entries, along with their respective average life expectancies.
SELECT 
SUM(CASE  WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count ,
AVG(CASE  WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Count, 
SUM(CASE  WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count ,
AVG(CASE  WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Count
FROM  world_life_expectancy; 



#This will output the average life expectancy for each status, rounded to one decimal place. 
SELECT Status,
ROUND(AVG(`Life expectancy`),1) 
from world_life_expectancy 
GROUP BY Status; 

#This query will provide each Status with the count of distinct countries and the average life expectancy.
SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`),1) 
from world_life_expectancy 
GROUP BY Status; 

#This should now work as intended, providing each country’s average life expectancy and BMI, ordered by BMI from highest to lowest.
SELECT Country, ROUND(AVG(`LIfe expectancy`),1) AS Life_Exp, ROUND (AVG(BMI),1) AS BMI
FROM world_life_expectancy 
GROUP BY Country 
HAVING Life_Exp > 0 
AND BMI > 0
ORDER BY BMI DESC;  


# This query will give you the Life expectancy, Adult Mortality, and cumulative Adult Mortality over time for each country matching the filter, ordered by year within each country.
SELECT Country,Year, `Life expectancy`, `Adult Mortality`, SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy 
WHERE Country LIKE '%United%'; 


























































