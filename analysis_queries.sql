USE ecommerce_sql_analysis;

-- 1. Total revenue from completed orders
SELECT SUM(order_total) AS total_revenue
FROM orders
WHERE status IN ('Delivered', 'Shipped');

-- 2. Revenue by category
SELECT p.category,
       ROUND(SUM(oi.line_total), 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered', 'Shipped')
GROUP BY p.category
ORDER BY revenue DESC;

-- 3. Top 10 customers by spending
SELECT c.customer_id, c.customer_name,
       ROUND(SUM(o.order_total), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status IN ('Delivered', 'Shipped')
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- 4. Monthly revenue
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       ROUND(SUM(order_total), 2) AS revenue
FROM orders
WHERE status IN ('Delivered', 'Shipped')
GROUP BY month
ORDER BY month;

-- 5. Average order value
SELECT ROUND(AVG(order_total), 2) AS average_order_value
FROM orders
WHERE status IN ('Delivered', 'Shipped');

-- 6. Most purchased products
SELECT p.product_name,
       SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered', 'Shipped')
GROUP BY p.product_id, p.product_name
ORDER BY units_sold DESC
LIMIT 10;

-- 7. Cities with the highest sales
SELECT c.city,
       ROUND(SUM(o.order_total), 2) AS total_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status IN ('Delivered', 'Shipped')
GROUP BY c.city
ORDER BY total_sales DESC;

-- 8. Most frequently used payment methods
SELECT p.payment_method,
       COUNT(*) AS payment_count
FROM payments p
JOIN orders o ON p.order_id = o.order_id
WHERE o.status IN ('Delivered', 'Shipped')
GROUP BY p.payment_method
ORDER BY payment_count DESC;

-- 9. Percentage of orders that are cancelled or returned
SELECT ROUND(
           100.0 * SUM(CASE WHEN status IN ('Cancelled', 'Returned') THEN 1 ELSE 0 END)
           / COUNT(*),
           2
       ) AS cancelled_returned_percentage
FROM orders;

-- 10. Customers who have placed more than 3 orders
SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 3
ORDER BY total_orders DESC;

-- 11. Products with the highest quantity sold
SELECT p.product_name,
       SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered', 'Shipped')
GROUP BY p.product_id, p.product_name
ORDER BY units_sold DESC;

-- 12. Revenue by discount level
SELECT CASE
           WHEN oi.discount = 0 THEN 'No Discount'
           WHEN oi.discount <= 0.05 THEN '1-5% Discount'
           WHEN oi.discount <= 0.10 THEN '6-10% Discount'
           ELSE 'Above 10% Discount'
       END AS discount_level,
       ROUND(SUM(oi.line_total), 2) AS revenue,
       SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered', 'Shipped')
GROUP BY discount_level
ORDER BY revenue DESC;
