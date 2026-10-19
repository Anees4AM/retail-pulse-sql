-- CREATING THE DATABASE FOR PROJECT FOR RETAIL AND SALES ANALYSIS
CREATE DATABASE sql_project_1;

-- DROPPINF DATABASE
drop database sql_project;

-- use database
USE sql_project_1;
show tables;

-- CREATING THE TABLE
DROP TABLE IF EXISTS ABX_table;
CREATE TABLE  ABX_table (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(25),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- SELECTING NEWLY CREATED TABLE
SELECT * FROM retail_sales_table
LIMIT 2010;
 
-- COUNT ROWS
SELECT COUNT(*) FROM retail_sales_table;

-- checking null values
SELECT * FROM retail_sales_table 
WHERE 
	category is null
	or
    transactions_id is null
    or 
    sale_date is null  
    or 
    customer_id is null
    or
    gender is null
    or
    age is null
    or 
    quantity is null
    or
    price_per_unit is null
    or
    cogs is null
    or 
    total_sale is null;
    
    -- deleting null values DATA CLEANING
DELETE FROM retail_sales_table 
WHERE 
	category is null
	or
    transactions_id is null
    or 
    sale_date is null  
    or 
    customer_id is null
    or
    gender is null
    or
    age is null
    or 
    quantity is null
    or
    price_per_unit is null
    or
    cogs is null
    or 
    total_sale is null;
    
-- safe mode disable 
SET SQL_SAFE_UPDATES = 0;

-- DATA EXPLORATION
-- How many sales we have?
Select count(*) total_sale from retail_sales_table;

-- HOW MANY CUSTOMER WE HAVE?
Select count(distinct customer_id) from retail_sales_table;

-- how many unique catergories we have?
Select distinct category from retail_sales_table;
-- count
Select count(distinct category) from retail_sales_table;

-- DATA ANALSYS AND BUISINESS KEY PROBLEMS

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
 SELECT * FROM retail_sales_table where sale_date = '2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than and equals to 3 in the month of Nov-2022
SELECT * FROM retail_sales_table where category = 'clothing' and quantity >='3' and year(sale_date)= '2022' and month(sale_date)= '11';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
 SELECT category as CAT, SUM(total_sale) as TOTAL_SALE , count(*) as total_order  FROM retail_sales_table GROUP BY category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT category as CATEGORY , avg(age) as AVG_AGE from retail_sales_table where category = 'beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * from retail_sales_table where total_sale > '1000';

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender, count(*)transaction_id from retail_sales_table group by category , gender order by 1 ; 

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
YEAR,
MONTH,
AVG_SALE
FROM
(
select 
EXTRACT(YEAR FROM sale_date) as YEAR,
EXTRACT(MONTH FROM sale_date) AS MONTH,
avg(total_sale) as AVG_SALE,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY avg(total_sale) DESC) AS rankX
from retail_sales_table
GROUP BY 1 ,2)
AS T1
WHERE rankX ='1'


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT
customer_id,
sum(total_sale) as totalsum
from retail_sales_table
group by 1
order by 2 desc
limit 5


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
category,
count(distinct customer_id) as UNIQUE_customer
 from retail_sales_table
 group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM retail_sales_table
GROUP BY shift;
S