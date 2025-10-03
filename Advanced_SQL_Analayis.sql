 -- ADVANCED SQL QUERIES

-- Q1: Percentage contribution of each pizza category to total revenue
SELECT pt.category,
       ROUND(
         (SUM(od.quantity * p.price) / 
          (SELECT SUM(od2.quantity * p2.price)
           FROM order_details od2
           JOIN pizzas p2 
             ON od2.pizza_id = p2.pizza_id)
         ) * 100, 2
       ) AS revenue_percentage
FROM pizza_types pt
JOIN pizzas p 
  ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od 
  ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY revenue_percentage DESC;

-- Q2: Cumulative revenue generated over time
SELECT sales.order_date, 
       SUM(sales.revenue) OVER (ORDER BY sales.order_date) AS cumulative_revenue
FROM (
    SELECT o.order_date, 
           SUM(od.quantity * p.price) AS revenue
    FROM orders o
    JOIN order_details od 
      ON o.order_id = od.order_id
    JOIN pizzas p 
      ON od.pizza_id = p.pizza_id
    GROUP BY o.order_date
) AS sales;

-- Q3: Top 3 most ordered pizza types based on revenue for each category
SELECT category, name, revenue, ranking
FROM (
    SELECT pt.category, 
           pt.name, 
           ROUND(SUM(od.quantity * p.price), 0) AS revenue,
           RANK() OVER(PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) AS ranking
    FROM order_details od
    JOIN pizzas p 
      ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt 
      ON pt.pizza_type_id = p.pizza_type_id
    GROUP BY pt.category, pt.name
) AS ranked
WHERE ranking <= 3
ORDER BY category, ranking;
 