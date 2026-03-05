--Top 5 products by revenue in 2024
 SELECT
     product_name,
     SUM(units_sold * unit_price_usd) AS total_revenue
FROM global_sales
WHERE sale_date >= '2024-01-01'
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 5;