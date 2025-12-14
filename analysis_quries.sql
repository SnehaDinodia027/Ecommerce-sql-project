--analysis_queries.sql

-- Total Revenue
SELECT 
    SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- Revenue by Category
SELECT 
    p.category,
    SUM(p.price * oi.quantity) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category;

-- Top Customers by Spending
SELECT 
    c.customer_name,
    SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Monthly Sales Trend
SELECT 
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(p.price * oi.quantity) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- Customer Order Frequency (Window Function)
SELECT 
    c.customer_name,
    COUNT(o.order_id) OVER (PARTITION BY c.customer_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
