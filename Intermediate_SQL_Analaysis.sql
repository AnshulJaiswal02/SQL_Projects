-- INTERMEDIATE SQL QUERIES

-- Q1: Find the total quantity of pizzas ordered per category
SELECT pt.category, 
       SUM(od.quantity) AS total_ordered
FROM pizza_types pt
JOIN pizzas p 
  ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od 
  ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY total_ordered DESC;

-- Q2: Distribution of orders by hour of the day
SELECT HOUR(o.order_time) AS order_hour,
       COUNT(o.order_id) AS orders_per_hour
FROM orders o
GROUP BY order_hour
ORDER BY order_hour;

-- Q3: Category-wise distribution of pizza varieties
SELECT pt.category, 
       COUNT(pt.name) AS pizza_count
FROM pizza_types pt
GROUP BY pt.category
ORDER BY pizza_count DESC;

-- Q4: Average number of pizzas ordered per day
SELECT ROUND(AVG(daily.quantity), 0) AS avg_per_day_order
FROM (
    SELECT o.order_date, 
           SUM(od.quantity) AS quantity
    FROM orders o
    JOIN order_details od 
      ON o.order_id = od.order_id
    GROUP BY o.order_date
) AS daily;

-- Q5: Top 3 most ordered pizza types based on revenue
SELECT pt.name, 
       SUM(od.quantity * p.price) AS revenue
FROM order_details od
JOIN pizzas p 
  ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
  ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;
