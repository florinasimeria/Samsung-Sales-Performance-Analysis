--The best-selling product in Europe
SELECT
    product_name,
    SUM(units_sold) AS Total_sold
    FROM global_sales
    WHERE region = 'Europe'
    GROUP BY product_name
    ORDER BY Total_sold DESC
    LIMIT 10;


 