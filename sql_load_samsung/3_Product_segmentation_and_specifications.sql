--Product segmentation and specifications
SELECT 
is_5g,
SUM(units_sold) AS total_units
FROM global_sales
GROUP BY is_5g;