# Retail and Sales Analysis Using SQL

## 📌 Project Overview

This project focuses on analyzing retail sales data using MySQL to understand sales performance, customer purchasing behavior, product categories, and transaction patterns.

The project involves database creation, data exploration, data cleaning, and solving business-related questions using SQL queries. It helped me practice SQL and understand how data can be used to answer business questions.

## 🎯 Project Objectives

- Create and manage a retail sales database.
- Explore sales transactions and customer information.
- Identify and handle missing values.
- Analyze sales across product categories.
- Understand customer purchasing behavior.
- Identify top customers based on total sales.
- Analyze monthly sales trends and order distribution by time of day.

## 🛠️ Tools & Technologies

- **Database:** MySQL
- **Language:** SQL
- **Concepts:** Data Cleaning, Data Exploration, Data Analysis, Business Querying

## 📂 Dataset Description

| Column | Description |
|---|---|
| `transactions_id` | Unique transaction identifier |
| `sale_date` | Date of the sale |
| `sale_time` | Time of the sale |
| `customer_id` | Customer identifier |
| `gender` | Gender of the customer |
| `age` | Age of the customer |
| `category` | Product category |
| `quantity` | Quantity purchased |
| `price_per_unit` | Price per unit |
| `cogs` | Cost of goods sold |
| `total_sale` | Total sales amount for the transaction |

## 🔍 Project Workflow

### 1. Database Creation
- Created a database named `sql_project_1`.
- Created a table to store retail sales transactions.
- Defined data types for transaction details, dates, customer information, and sales figures.

### 2. Data Exploration
- Retrieved records from the dataset.
- Counted total transactions and unique customers.
- Identified distinct product categories.

### 3. Data Cleaning
- Checked important columns for NULL values.
- Identified incomplete records.
- Removed records containing NULL values from selected columns.

### 4. Data Analysis
- Analyzed sales by product category.
- Examined customer demographics and purchasing patterns.
- Compared average transaction sales by month.
- Identified high-value transactions and top customers.
- Grouped orders by time of day.

## 📊 Business Questions & SQL Analysis

### Q1. Retrieve all sales made on November 5, 2022

```sql
SELECT *
FROM retail_sales_table
WHERE sale_date = '2022-11-05';
```

---

### Q2. Find clothing transactions with a quantity of at least 3 in November 2022

```sql
SELECT *
FROM retail_sales_table
WHERE category = 'Clothing'
  AND quantity >= 3
  AND YEAR(sale_date) = 2022
  AND MONTH(sale_date) = 11;
```

---

### Q3. Calculate total sales and the number of transactions for each category

```sql
SELECT
    category,
    SUM(total_sale) AS total_sales,
    COUNT(*) AS total_orders
FROM retail_sales_table
GROUP BY category;
```

---

### Q4. Find the average age of customers who purchased items from the Beauty category

```sql
SELECT
    AVG(age) AS avg_age
FROM retail_sales_table
WHERE category = 'Beauty';
```

---

### Q5. Find all transactions where the total sale is greater than 1,000

```sql
SELECT *
FROM retail_sales_table
WHERE total_sale > 1000;
```

---

### Q6. Find the number of transactions for each gender in each category

```sql
SELECT
    category,
    gender,
    COUNT(*) AS total_transactions
FROM retail_sales_table
GROUP BY category, gender
ORDER BY category;
```

---

### Q7. Find the best-selling month in each year based on average sales per transaction

```sql
SELECT
    year,
    month,
    avg_sale
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sales_rank
    FROM retail_sales_table
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS monthly_sales
WHERE sales_rank = 1;
```

---

### Q8. Find the top 5 customers based on total sales

```sql
SELECT
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales_table
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

### Q9. Find the number of unique customers in each category

```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales_table
GROUP BY category;
```

---

### Q10. Categorize orders into morning, afternoon, and evening shifts

- Morning: Before 12 PM
- Afternoon: 12 PM to 5:59 PM
- Evening: 6 PM onwards

```sql
SELECT
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM retail_sales_table
GROUP BY shift
ORDER BY FIELD(shift, 'Morning', 'Afternoon', 'Evening');
```

---

## 🧠 SQL Concepts Practiced

- Database and table creation
- `SELECT`, `WHERE`, and `DISTINCT`
- Aggregate functions: `COUNT()`, `SUM()`, and `AVG()`
- `GROUP BY` and `ORDER BY`
- Date and time functions
- Conditional logic using `CASE`
- Window functions using `RANK() OVER()`
- Subqueries
- `COUNT(DISTINCT ...)`
- Filtering and limiting results
- Data cleaning using `IS NULL` and `DELETE`

## 📈 Key Learning Outcomes

- Practiced writing SQL queries to solve business problems.
- Learned to group and aggregate transaction data.
- Applied date and time functions to analyze sales patterns.
- Used ranking functions to identify the highest-performing month in each year.
- Gained experience translating business questions into SQL queries.

## 🚀 How to Run the Project

1. Install MySQL and open MySQL Workbench or another MySQL-compatible SQL editor.
2. Clone or download this repository.
3. Import the retail sales dataset into MySQL.
4. Run the database and table creation statements.
5. Execute the data exploration and cleaning queries.
6. Run the business analysis queries to explore the results.

## 📁 Project Files

- `retail_sales_analysis.sql` — SQL queries for database creation, data exploration, cleaning, and analysis.
- `README.md` — Project documentation.

*Include the dataset file in the repository if you have permission to share it.*

## 👨‍💻 Author

**Anees Maqsood**

Electronics and Communication Engineering Graduate | Aspiring Data Analyst
