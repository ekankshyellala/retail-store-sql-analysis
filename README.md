#  Retail Store SQL Analysis

##  Project Overview

This project is a Retail Store Management System built using MySQL to practice and demonstrate SQL skills required for Data Analyst and Business Analyst  roles.

The database consists of three related tables-- Customers, Orders, and Products and includes solutions to 80+ real-world business SQL problems  ranging from beginner to advanced level.


##  Database Schema

<img width="1536" height="1024" alt="db_schema_3_tables" src="https://github.com/user-attachments/assets/3ba414c9-96e0-42ae-b833-b7e135531ed1" />

##  Database Structure

###  Customers

| Column | Description |
|---------|-------------|
| CustomerID | Primary Key |
| CustomerName | Customer Name |
| City | Customer City |
| Gender | Customer Gender |
| SignupDate | Customer Registration Date |



###  Products

| Column | Description |
|---------|-------------|
| ProductID | Primary Key |
| ProductName | Product Name |
| Category | Product Category |
| Price | Product Price |


###  Orders

| Column | Description |
|---------|-------------|
| OrderID | Primary Key |
| CustomerID | Foreign Key |
| ProductID | Foreign Key |
| Quantity | Quantity Purchased |
| OrderDate | Date of Purchase |



#  Technologies Used

- MySQL 8.0
- MySQL Workbench
- GitHub


#  SQL Concepts Covered

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- Aggregate Functions
- INNER JOIN
- LEFT JOIN
- Common Table Expressions (CTEs)
- Window Functions
  - ROW_NUMBER()
  - RANK()
  - DENSE_RANK()
  - LAG()
  - LEAD()
- Running Totals
- Ranking
- Revenue Analysis
- Percentage Contribution
- Date Functions


#  Business Problems Solved

✔ Total Revenue Analysis

✔ Revenue by Product

✔ Revenue by Category

✔ Revenue by City

✔ Top Spending Customers

✔ Customer-wise Purchase Analysis

✔ Running Revenue

✔ Product Ranking

✔ Customer Ranking

✔ Repeat Customers

✔ First & Latest Purchases

✔ Customer Revenue Contribution (%)

✔ Peak & Valley Purchases

✔ Product Performance Analysis

✔ Monthly Sales Trend



#  Learning Outcomes

Through this project, I strengthened my understanding of:

- Writing efficient SQL queries
- Relational database design
- Solving real-world business problems using SQL
- Analytical thinking with SQL
- Customer and sales analytics using window functions
- Revenue and product performance analysis

  
About Me:
I am an aspiring Data Analyst passionate about transforming raw data into meaningful business insights.
I am currently building end-to-end projects in:

- SQL
- Python
- Pandas
- Excel
- Power BI
- Statistics
