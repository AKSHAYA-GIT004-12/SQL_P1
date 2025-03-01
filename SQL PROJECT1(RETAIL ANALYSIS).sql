-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;


-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM retail_sales
LIMIT 10


    

SELECT 
    COUNT(*) 
FROM retail_sales

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT*FROM RETAIL_SALESTABLE;
SELECT*FROM RETAIL_SALESTABLE WHERE TRANSACTIONS_ID IS NULL;
SELECT*FROM RETAIL_SALESTABLE
WHERE
TRANSACTIONS_ID IS NULL
OR
SALE_DATE IS NULL
OR
SALE_TIME IS NULL
OR
CUSTOMER_ID IS NULL
OR
GENDER IS NULL
OR
AGE IS NULL
OR 
CATEGORY IS NULL
OR 
QUANTIY IS NULL
OR 
PRICE_PER_UNIT IS NULL
OR
COGS IS NULL
OR
TOTAL_SALE IS NULL;
DELETE FROM RETAIL_SALESTABLE
WHERE
TRANSACTIONS_ID IS NULL
OR
SALE_DATE IS NULL
OR
SALE_TIME IS NULL
OR
CUSTOMER_ID IS NULL
OR
GENDER IS NULL
OR
AGE IS NULL
OR 
CATEGORY IS NULL
OR 
QUANTIY IS NULL
OR 
PRICE_PER_UNIT IS NULL
OR
COGS IS NULL
OR
TOTAL_SALE IS NULL;
--DATA EXPLORATION
--HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS TOTAL_SALES FROM RETAIL_SALESTABLE;
--HOW MANY UNIQUE CUSTOMERS WE HAVE?
SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_SALES FROM RETAIL_SALESTABLE;
--HOW MANY UNIQUE CATEGORIES WE HAVE?
SELECT COUNT(DISTINCT CATEGORY) AS TOTAL_SALES FROM RETAIL_SALESTABLE;


SELECT DISTINCT CATEGORY FROM RETAIL_SALESTABLE;
SELECT DISTINCT category FROM retail_sales


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT*FROM RETAIL_SALESTABLE WHERE SALE_DATE='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT*FROM RETAIL_SALESTABLE WHERE CATEGORY='Clothing' AND TO_CHAR(SALE_DATE,'YYYY-MM')='2022-11'AND QUANTIY>=4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category
SELECT CATEGORY,SUM(TOTAL_SALE) AS NETSALE,COUNT(*)
FROM RETAIL_SALESTABLE
GROUP BY CATEGORY;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT ROUND(AVG(AGE),2) AS AVERAGE
FROM RETAIL_SALESTABLE
WHERE CATEGORY='Clothing';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT*FROM RETAIL_SALESTABLE WHERE TOTAL_SALE>=1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT CATEGORY,GENDER,COUNT(*) AS COUNTVALUE
FROM RETAIL_SALESTABLE 
GROUP BY CATEGORY,GENDER
ORDER BY 1;

SELECT*FROM RETAIL_SALESTABLE;

--Q.7 WRITE A QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH.FIND OUT THE BEST SELLING MONTH OF THE YEAR.
SELECT
year,
month,
TOTALSALE
FROM
(
SELECT 
EXTRACT(YEAR FROM SALE_DATE) AS year,
EXTRACT(MONTH FROM SALE_DATE) AS month,
AVG(TOTAL_SALE) AS TOTALSALE,
RANK()OVER(PARTITION BY EXTRACT(YEAR FROM SALE_DATE) ORDER BY AVG(TOTAL_SALE) DESC )
FROM RETAIL_SALESTABLE
GROUP BY 1,2
)AS T1
WHERE RANK='1';

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT CUSTOMER_ID,SUM(TOTAL_SALE)AS TOTALVALUE 
FROM RETAIL_SALESTABLE
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category
SELECT
CATEGORY,
COUNT(DISTINCT CUSTOMER_ID)
FROM RETAIL_SALESTABLE
GROUP BY 1;

SELECT*FROM RETAIL_SALESTABLE;

--Q.10 WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS(EG MORNING<12,AFTERNOON BETWEEN 12 AND 17,EVENING >17)
WITH HOURLY_SALE
AS(
SELECT*,
 CASE
    WHEN EXTRACT(HOUR FROM SALE_TIME)<12 THEN 'MORNING'
    WHEN EXTRACT(HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN 'AFTERNOON'
    ELSE 'EVENING'
 END AS SHIFT
FROM RETAIL_SALESTABLE
)
SELECT 
   SHIFT,
   COUNT(*)AS TOTAL 
FROM HOURLY_SALE
GROUP BY SHIFT;

--END OF PROJECT



