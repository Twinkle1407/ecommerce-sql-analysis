# E-commerce Customer & Order Analysis — MySQL

## Project Overview
This project analyzes e-commerce customers, products, orders, order items, and payments using MySQL.

**Note:** The dataset in this project is synthetically generated for portfolio practice and SQL demonstration.

## Database
`ecommerce_sql_analysis`

## Tables
- `customers` — customer details and location
- `products` — product and category information
- `orders` — order date, status, shipping fee, and total
- `order_items` — products purchased, quantities, discounts, and line totals
- `payments` — payment method and paid amount

## Business Questions
1. What is total revenue from delivered and shipped orders?
2. Which product categories generate the most revenue?
3. Which cities have the highest sales?
4. Who are the top 10 customers by spending?
5. What is the monthly revenue trend?
6. Which products are most frequently purchased?
7. What is the average order value?
8. Which payment methods are used most often?
9. What percentage of orders are cancelled or returned?
10. Which customers have placed more than 3 orders?
11. Which products have the highest quantity sold?
12. How does discount level relate to revenue?

## SQL Skills Demonstrated
- SELECT, WHERE, ORDER BY
- GROUP BY and aggregate functions
- INNER/LEFT JOIN
- CASE
- Subqueries
- CTEs
- Window functions
- Date functions
- Conditional aggregation

## How to Use
1. Open MySQL Workbench.
2. Open `ecommerce_sql_analysis.sql`.
3. Execute the complete script.
4. Select the `ecommerce_sql_analysis` database.
5. Run the analysis queries you build for the business questions.
