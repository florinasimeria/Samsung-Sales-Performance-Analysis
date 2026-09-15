
# 📊 Samsung Sales Performance Analysis

<div align="center">

### SQL • PostgreSQL • Power BI • Data Analysis

Analyze sales data • Discover trends • Generate business insights
</div>

---

# 📌 Project Overview

This project analyzes **Samsung Electronics sales data** between **2021 and 2024** using **SQL** and **Power BI**.

The objective is to answer real business questions by exploring sales performance, revenue trends, customer preferences, and the adoption of **5G technology**.

The dataset is based on practice data from **Kaggle** and was analyzed using **PostgreSQL**. Power BI was used to create dashboards that visualize the results.

---

# 🛠 Technologies Used

- 💾 SQL
- 🐘 PostgreSQL
- 📊 Power BI
- 💻 Visual Studio Code
- 🌿 Git
- 🐙 GitHub

---
# 📂 Dataset

| Property | Value |
|----------|-------|
| Source | Kaggle Practice Dataset |
| Period | 2021–2024 |
| Industry | Consumer Electronics |
| Database | PostgreSQL |

---
# ❓ Business Questions

This project answers the following business questions:

- [x] Percentage sales by country
- [x] Year-over-Year (YoY) growth
- [x] 5G technology adoption
- [x] Best-selling products in Europe
- [x] Top 5 products by revenue in 2024

---
---

# 📈 Analysis

---

## 1️⃣ Percentage Sales by Country

### 🎯 Business Question

What is the sales share of each product within every European country?

### 🧠 SQL Concepts Used

- Common Table Expressions (CTE)
- Window Functions
- SUM()
- RANK()
- GROUP BY
- Aggregation

### 📝 SQL Query

```sql
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
FROM ProductSales; 
```

### 📊 Result

The analysis identified the best-selling Samsung product in every European country and calculated its contribution to each country's total sales.

For example, in **Belgium**, the **Samsung Galaxy Tab A9+** represented **6.84%** of total Samsung sales.

### 📷 Power BI Dashboard

<img width="601" height="358" alt="1 percent sales" src="https://github.com/user-attachments/assets/800e1d92-e68c-4862-9257-36f1cbba720f" />


### 💡 Business Insight

The analysis highlights product preferences across European markets and can support localized marketing strategies.

---

## 2️⃣ Year-over-Year (YoY) Growth

### 🎯 Business Question

How have Samsung sales evolved each year?

### 🧠 SQL Concepts Used

- LAG()
- CASE
- EXTRACT()
- Window Functions
- Aggregation

### 📝 SQL Query

```sql
--Annual report: extracting the year, calculating the total units sold, and using a function (LAG) to compare the results with the previous year.
--Analyze increase and decrease.
WITH YearlySale AS (
    SELECT 
        EXTRACT (YEAR FROM sale_date) AS year,
        SUM(units_sold) AS Total_units
        FROM global_sales
        WHERE region = 'Europe'
        GROUP BY EXTRACT (YEAR FROM sale_date)
)
SELECT 
    year,
    Total_units,
    LAG (Total_units) OVER (ORDER BY year) AS previous_year_units,
    CASE 
        WHEN LAG (Total_units) OVER (ORDER BY year) IS NULL THEN '0'
        ELSE 
            ROUND (
            ((Total_units - LAG (Total_units)OVER (ORDER BY year)) * 100.0 ) 
            / LAG (Total_units) OVER (ORDER BY year),
             2
        )   ::TEXT ||'%'
    END AS yoy_growth,
    CASE 
        WHEN Total_units > LAG (Total_units)OVER (ORDER BY year) THEN 'Increase'
        WHEN Total_units < LAG (Total_units)OVER (ORDER BY year) THEN 'Decrease'
        WHEN Total_units = LAG (Total_units)OVER (ORDER BY year) THEN 'Constant'
        ELSE 'N/A'
    END AS trend_status
    FROM YearlySale
    ORDER BY year DESC;
```

### 📊 Result

The analysis shows the yearly sales evolution and calculates the percentage increase or decrease compared to the previous year.

- 2022: **+3.37%**
- 2023: **+0.93%**
- 2024: **+1.68%**

### 📷 Power BI Dashboard

<img width="605" height="358" alt="yearly_sales_evolution" src="https://github.com/user-attachments/assets/a3d3281d-7463-4cfa-9337-a13726249e85" />


### 💡 Business Insight

Although growth slowed during 2023, sales increased again in 2024, indicating continued market expansion.

---

## 3️⃣ Popularity of 5G Technology

### 🎯 Business Question

How popular are 5G-enabled Samsung devices?

### 🧠 SQL Concepts Used

- GROUP BY
- Aggregation

### 📝 SQL Query

```sql
--Product segmentation and specifications
SELECT 
is_5g,
SUM(units_sold) AS total_units
FROM global_sales
GROUP BY is_5g;
```

### 📊 Result

Only **32.72%** of all products sold globally support **5G technology**.

### 📷 Power BI Dashboard

<img width="602" height="333" alt="5g_technology" src="https://github.com/user-attachments/assets/6fb95762-1b6a-411e-b2d3-ccfcea395a29" />

### 💡 Business Insight

Although 5G adoption continues to grow, most customers still purchase non-5G devices, suggesting that affordability remains an important factor.

---

## 4️⃣ Best-Selling Products in Europe

### 🎯 Business Question

Which Samsung products sold the most in Europe?

### 🧠 SQL Concepts Used

- GROUP BY
- ORDER BY
- LIMIT

### 📝 SQL Query

```sql
--The best-selling product in Europe
SELECT
    product_name,
    SUM(units_sold) AS Total_sold
    FROM global_sales
    WHERE region = 'Europe'
    GROUP BY product_name
    ORDER BY Total_sold DESC
    LIMIT 10;
```

### 📊 Result

The **Samsung Galaxy Tab S9 FE** ranked as the best-selling Samsung product in Europe, with **240 units sold** during the analyzed period.

### 📷 SQL result table

<img width="188" height="215" alt="best_selling_product_E" src="https://github.com/user-attachments/assets/cec0837f-0707-4c22-ad91-e3101bd02c8f" />

### 💡 Business Insight

Tablet devices showed particularly strong demand in the European market.

---

## 5️⃣ Top 5 Products by Revenue (2024)

### 🎯 Business Question

Which Samsung products generated the highest revenue in 2024?

### 🧠 SQL Concepts Used

- SUM()
- ORDER BY
- LIMIT

### 📝 SQL Query

```sql
--Top 5 products by revenue in 2024
 SELECT
     product_name,
     SUM(units_sold * unit_price_usd) AS total_revenue
FROM global_sales
WHERE sale_date >= '2024-01-01'
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 5;
```

### 📊 Result

Top revenue-generating products:

| Product | Revenue |
|----------|---------:|
| Samsung 65" OLED S95C | $122,511.42 |
| Samsung Neo QLED 8K QN900C | $109,824.07 |
| Samsung Galaxy Z Fold 5 | $105,707.85 |
| Samsung French Door Refrigerator | $105,453.57 |
| Samsung Galaxy Z Fold 4 | $89,584.94 |


### 💡 Business Insight

Premium devices generated the highest revenue despite lower sales volumes, highlighting the importance of high-value product segments.

---

# 📌 Key Takeaways

During this project I strengthened my skills in:

- Advanced SQL Queries
- PostgreSQL
- Data Aggregation
- Window Functions
- Power BI Dashboards
- Data Visualization
- Business Analysis
- Analytical Thinking

This project helped me transform raw sales data into meaningful business insights using SQL and Power BI.

---

# 🚀 Future Improvements

- Expand the analysis with customer segmentation
- Create interactive Power BI dashboards
- Add sales forecasting
- Build a PostgreSQL database from raw CSV files
- Include additional KPI analysis

---
---

# 👩‍💻 About the Author

## Florina Simeria

Software Quality Assurance 

Passionate about SQL, Test Automation and Data Analysis.

- 💼 LinkedIn: https://www.linkedin.com/in/florina-simeria-353a553a9/
- 🐙 GitHub: https://github.com/florinasimeria
