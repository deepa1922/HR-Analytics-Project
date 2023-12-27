-- DATA CLEANING
CREATE DATABASE Projects;

USE Projects;

-- Displaying data from the 'hr' table
SELECT * FROM hr;

-- modifying the column name
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_ID VARCHAR(20) NULL;

-- Check data Type
DESCRIBE hr;

SELECT birthdate FROM hr;

-- Updating 'birthdate' column to a standardized format

-- Disable safe update mode to allow unrestricted UPDATE statements
SET sql_safe_updates = 0;
UPDATE hr
SET birthdate = CASE
     WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
     WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
     ELSE NULL 
END;

-- Modifying the data type of 'birthdate' column to DATE
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

-- -- Updating 'hire_date' column to a standardized format 
UPDATE hr
SET hire_date = CASE
     WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
     WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
     ELSE NULL 
END;

-- Modifying the data type of 'hire_date' column to DATE
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- Updating 'termdate' column to a standardized format
UPDATE hr
SET termdate = CASE
    WHEN termdate IS NOT NULL AND termdate != '' THEN date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
    ELSE NULL
END;

-- Modifying the data type of 'termdate'
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- -- Adding 'age' column to the 'hr' table
ALTER TABLE hr ADD COLUMN age INT;

-- Updating 'age' column
UPDATE hr
SET age = timestampdiff(YEAR, birthdate,CURDATE());
SELECT birthdate,age FROM hr;

-- Analyze Age Data

-- Identifying the youngest and oldest employees based on age
SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

-- Counting employees with negative age values(potentially erroneous)
SELECT count(*) FROM hr WHERE age < 18;

-- Counting employees with a termination date in the future (potentially erroneous)
SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

-- Counting employees with a NULL termination date
SELECT COUNT(*)
FROM hr
WHERE termdate = NULL;



