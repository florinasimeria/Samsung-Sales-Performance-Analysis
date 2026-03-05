--What is the share of each product in total sales in the country (percentage)

WITH ProductSales AS (
    SELECT
    country,
    product_name,
    SUM(units_sold) AS total_sold,
    SUM(SUM(units_sold)) OVER (PARTITION BY country) AS country_total,
    RANK () OVER(
        PARTITION BY country 
        ORDER BY SUM(units_sold)DESC
    ) AS sales_rank
    FROM global_sales
    WHERE region = 'Europe'
    GROUP BY country,
     product_name
    )
SELECT
    country,
    product_name,
    total_sold,
    ROUND ((Total_sold * 100.0) / country_total, 2) ::TEXT || '%' AS percentage
FROM ProductSales
WHERE sales_rank = 1; 