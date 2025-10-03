-- BEGINNER SQL QUERIES

-- Q1: Retrieve the total number of orders placed
SELECT COUNT(order_id) AS total_orders
FROM orders;

-- Q2: Calculate total revenue generated from all sales
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p 
  ON od.pizza_id = p.pizza_id;

-- Q3a: Identify the highest-priced pizza (using subquery)
SELECT pizza_id, price
FROM pizzas
WHERE price = (SELECT MAX(price) FROM pizzas);

-- Q3b: Identify the highest-priced pizza (with join to pizza_types)
SELECT pt.name, p.price
FROM pizza_types pt
JOIN pizzas p 
  ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- Q4: Identify the most common pizza size ordered
SELECT p.size, 
       COUNT(od.order_details_id) AS order_count
FROM pizzas p
JOIN order_details od 
  ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY order_count DESC
LIMIT 1;

-- Q5a: List the top 5 most ordered pizza IDs
SELECT p.pizza_id, 
       COUNT(od.order_details_id) AS pizza_count
FROM pizzas p
JOIN order_details od 
  ON od.pizza_id = p.pizza_id
GROUP BY p.pizza_id
ORDER BY pizza_count DESC
LIMIT 5;

-- Q5b: List the top 5 most ordered pizza types with quantities
SELECT pt.name, 
       SUM(od.quantity) AS total_ordered
FROM pizza_types pt
JOIN pizzas p 
  ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od 
  ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY total_ordered DESC
LIMIT 5;

