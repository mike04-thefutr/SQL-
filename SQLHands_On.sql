CREATE TABLE EmployeeDemographics
(EmployeeID int, 
Firstname varchar(50), 
Lastname varchar(50), 
Age int, 
Gender varchar(50) 
)
----this is to create a table using this format just to clear any confusion 
--numeric values are integers and strings are varchar 

--were gonna do another one 
CREATE TABLE EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int)

---once done right click and click on "select top 1000 rows"

---now we want to insert the data to our tables 

INSERT INTO EmployeeDemographics VALUES  
(1002, 'Pam', 'Beasley', 30, 'Female'), 
(1003, 'Dwight', 'Schrute', 29, 'Male'), 
(1004, 'Angela', 'Martin', 31, 'Female'), 
(1005, 'Toby', 'Flenderson', 32, 'Male'), 
(1006, 'Michael', 'Scott', 35, 'Male'), 
(1007, 'Meredith', 'Palmer', 32, 'Female'), 
(1008, 'Stanley', 'Hudson', 38, 'Male'), 
(1009, 'Kevin', 'Malone', 31, 'Male')

INSERT INTO EmployeeSalary VALUES 
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000), 
(1003, 'Salesman', 63000), 
(1004, 'Accountant', 47000), 
(1005, 'HR', 50000), 
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000), 
(1009, 'Accountant', 42000)

----Now we will do some querying 
---When we use DISTINCT, we want unique values in a specfic column
SELECT TOP 5 *
FROM EmployeeDemographics

--COUNT, shows us all non null values in a column 

SELECT MIN(Salary)
FROM EmployeeSalary


SELECT MAX(Salary)
FROM EmployeeSalary

SELECT AVG(Salary)
FROM EmployeeSalary

---WHERE STATEMENTS, helps limit amount of data and specify what data you want returned
--example

SELECT *
FROM EmployeeDemographics
WHERE Firstname = 'Jim'

---this sign <> means does not equal, will return names that are not Jim
/*
WHERE STATEMENT 
=, <>, <, >, AND, LIKE, IS NULL, IS NOT NULL, IN
*/
SELECT *
FROM EmployeeDemographics
WHERE Firstname <> 'Jim'

---lets say you want everybody whose last name starts with 'S'

SELECT *
FROM EmployeeDemographics
WHERE Lastname LIKE 'S%'
--by doing this you want to return any last name that start with s 

SELECT *
FROM EmployeeDemographics
WHERE Lastname LIKE '%S%'
---but if you put this sign % in both sides of the letter you are saying you want to return last names that has an 'S' in it 

--IN is like the equal statement but like mutiple equal statements 
--so instead of doing a condition for each one you can use IN all in one 
SELECT *
FROM EmployeeDemographics
WHERE Firstname IN('Jim', 'Michael')

/*
GROUP BY, ORDER BY
*/
SELECT *
FROM EmployeeDemographics
ORDER BY Age Desc, Gender Desc
--if you notice the oldest age is ordered first, and for gender male goes first because it goes before female in terms of abcs

/*GROUP BY is similar to DISTINCT, but DISTINCT, returns the very first unique value 
and GROUP BY will show unique values and rolling them up in one column */

---JOINS (INNER, FULL, RIGHT, LEFT, OUTER JOINS

SELECT *
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--based on this were looking at things that're similar based off EmployyeeID in both tables


SELECT EmployeeDemographics.EmployeeID, Firstname, Lastname, JobTitle, Salary
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--if selecting employee id, ensure that you specify from which table otherwise it would be confusing as database wont know which employee id your referring to 

SELECT JobTitle, Salary
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE Jobtitle = 'Salesman'
---since we want to know the average, and using aggregate function we have to use group by function as well
SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE Jobtitle = 'Salesman'
GROUP BY JobTitle

--CASE STATEMENTS, allows to specify conditions, specifiy what you want return when condition is met 
--whatever condition you list first will execute in that way 
SELECT Firstname, Lastname, Age,
 CASE 
    WHEN Age >30 THEN 'Old'
	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby'
	END 
FROM EmployeeDemographics
WHERE Age IS NOT NULL 
ORDER BY Age 

--were gonna use a case statement to calculate what their salary gonna be after they get their raise 
SELECT Firstname, Lastname, JobTitle, Salary
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


SELECT Firstname, Lastname, JobTitle, Salary,
CASE
    WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
	ELSE Salary + (Salary * .03)
	END AS SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


---------------------------------------Having Clauses and understanding them-----------------------------------------------------


SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
/*
this is where the having clause comes into play
lets say we want to look at all the jobs that have more than 1 person in that specific job 
also GROUP BY goes before HAVING and HAVING goes after GROUP BY clause, cuz we cant look at aggregated info before its aggregated in that group by statement 
*/
 
SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1

SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)

-----------------------------------------------ALIASING-------------------------------------------------------------------
--aliasing helps clear any confusion by putting a name on something 

SELECT Firstname + ' ' + Lastname AS Full_Name
FROM EmployeeDemographics


SELECT AVG(Age) AS Avg_Age
FROM EmployeeDemographics

--alias in table names 
/*
when you alias in a table name, in select statement you have to preface column name with a table name(alias name)
like this aliasname.column
*/
SELECT Demo.EmployeeID
FROM EmployeeDemographics AS Demo

SELECT Demo.EmployeeID, Sal.Salary
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary AS Sal
ON Demo.EmployeeID = Sal.EmployeeID

--------------------------------PARTITION BY-----------------------------------------------
/*
divides the results into partitions(divided into parts) and changes how the window function is calc
*/
--in this query, we want to identify how many male and female(GENDER) employees we have
SELECT Firstname, Lastname, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary AS Sal
ON Demo.EmployeeID = Sal.EmployeeID

SELECT  Gender, COUNT(Gender)
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary AS Sal
ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY Gender

--PARTITION BY basically takes this query and sticking it into one line in select statement 


--------------------------------------------------CTE--------------------------------------------------------------
--CTE, its like a subquery and created out of memory so once we cancel query its like it never existed

WITH CTE_Employee AS 
(SELECT Firstname, Lastname, Gender, Salary 
, COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
, AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal 
ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)
SELECT *
FROM CTE_Employee
--
/*
now what we are doing is selecting everthing from whats inside the parathesis which we created (CTE)
weCAN SELECT THE COLUMNS WE SPECIFICALLY WANT AS WELL
CTE's are not stored anywhere 
you have to run it with the entire CTE
*/
WITH CTE_Employee AS 
(SELECT Firstname, Lastname, Gender, Salary 
, COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
, AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal 
ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)
SELECT Firstname, AvgSalary
FROM CTE_Employee

------------------------------------------------temp tables---------------------------------------------------------
/*
difference between a table and temp table is temp table start with #tablename
*/
CREATE TABLE #temp_Employee ( 
EmployeeID int, 
JobTitle varchar(100),
Salary int, 
)

SELECT * 
FROM #temp_Employee

INSERT INTO #temp_Employee VALUES(
'1001', 'HR', '45000'
)

INSERT INTO #temp_Employee
SELECT * 
FROM EmployeeSalary

--we took all the data from employee salary and stuck into #temp_employee table

--so why temp tables?
--reason is lets say employee salary had alot of rows and were trying to hit complex query (joins, other functions) it would take alot of time
--but we can do insert that data into temp table and then it already has subsection of data that we want to use 

--how it can be applied 

CREATE TABLE #temp_employee2 (
JobTitle varchar(50),
EmployeesPerJob int, 
AvgAge int, 
AvgSalary int)

INSERT INTO #temp_employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal 
ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_employee2

--now we have a subsection of data from this join above and what this does is take these exact values and placed into temp table 
--reducing runtime when your placing data into temp table 


--also if you want to run/execute all 3 queries make sure to state above CREATE TABLE 
---write DROP TABLE IF EXISTS #temptable

DROP TABLE IF EXISTS #temp_employee2
CREATE TABLE #temp_employee2 (
JobTitle varchar(50),
EmployeesPerJob int, 
AvgAge int, 
AvgSalary int)

INSERT INTO #temp_employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal 
ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_employee2

------------------------------------------------STRING FUNCTIONS----------------------------------------------------
/*
string functions( TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower 
*/

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50), 
Firstname varchar(50), 
Lastname varchar (50)
)

INSERT INTO EmployeeErrors VALUES 
('1001', 'Jimbo', 'Halbert'),
('1002', 'Pamela', 'Beasley'),   
('1005', 'TOby', 'Flenderson - Fired')

SELECT *
FROM EmployeeErrors

--now that we create our table with errors
--we will demonstrate how to correct them using TRIMS, RTRIM, LTRIM

---TRIM 
SELECT EmployeeID, TRIM(EmployeeID) AS TRIMID
FROM EmployeeErrors

--Replace
SELECT Lastname, REPLACE(Lastname, '- Fired', '')AS LastnameFixed
FROM EmployeeErrors 
 
--substring
---what those numbers mean, its gonna take firstname start at very 1st letter or number and go foward 3 spaces/spots
SELECT SUBSTRING(Firstname, 1, 3)
FROM EmployeeErrors	

SELECT SUBSTRING(err.Firstname,1,3), SUBSTRING(dem.Firstname,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem 
ON SUBSTRING(err.Firstname,1,3) = SUBSTRING(dem.Firstname,1,3)

-----------------------------UPPER and LOWER------------------------------------------------------
 
SELECT Firstname, LOWER(Firstname)
FROM EmployeeErrors

SELECT Firstname, UPPER(Firstname)
FROM EmployeeErrors

-------------------------------------------SUBQUERIES----------------------------------------------------------------
SELECT *
FROM EmployeeSalary

--subquery in SELECT 

SELECT EmployeeID, Salary,(SELECT AVG(Salary) FROM EmployeeSalary) AS AvgSalary
FROM EmployeeSalary

--doing it with PARTITION BY 
SELECT EmployeeID, Salary,AVG(Salary) OVER () AvgSalary 
FROM EmployeeSalary

---subquery in WHERE
--we only want to return employees over the age of 30
SELECT EmployeeID, JobTitle, Salary 
FROM EmployeeSalary
WHERE EmployeeID IN (
SELECT EmployeeID
FROM EmployeeDemographics
WHERE Age > 30)