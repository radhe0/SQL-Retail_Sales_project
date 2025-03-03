# 🚀 Retail Sales Analysis SQL Project

## 📌 Project Overview

**🔹 Project Title**: Retail Sales Analysis  
**🔹 Level**: Beginner  
**🔹 Database**: `SQL - Retail Sales Analysis_utf`

This project demonstrates essential SQL skills for data analysts to explore, clean, and analyze retail sales data. It involves setting up a retail sales database, performing Exploratory Data Analysis (EDA), and answering business questions using SQL queries. Perfect for beginners looking to build a strong SQL foundation!

---

## 🎯 Objectives

✅ **Set up a retail sales database** – Create and populate the database with sales data.  
✅ **Data Cleaning** – Identify and remove records with missing values.  
✅ **Exploratory Data Analysis (EDA)** – Understand the dataset through various queries.  
✅ **Business Analysis** – Derive insights and answer business questions using SQL.

---

## 🏗️ Project Structure

### 📂 1. Database Setup

📌 **Database Creation** – Setting up `p1_retail_db` with a table for sales data.  
📌 **Table Creation** – The `retail_sales` table stores transaction details.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,    
    sale_time TIME,
    customer_id INT,    
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,    
    cogs FLOAT,
    total_sale FLOAT
);
```

### 🧼 2. Data Exploration & Cleaning

🔍 **Checking Data Quality**

```sql
SELECT COUNT(*) FROM retail_sales; -- Total Records
SELECT COUNT(DISTINCT customer_id) FROM retail_sales; -- Unique Customers
SELECT DISTINCT category FROM retail_sales; -- Product Categories
```

🗑 **Handling Null Values**

```sql
DELETE FROM retail_sales
WHERE
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR
    gender IS NULL OR age IS NULL OR category IS NULL OR
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

---

## 📊 Data Analysis & Findings

### 🔹 1️⃣ Retrieve All Sales on '2022-11-05'
```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```

### 🔹 2️⃣ Find Clothing Sales > 4 in Nov 2022
```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing' AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantity >= 4;
```

### 🔹 3️⃣ Calculate Total Sales per Category
```sql
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_orders
FROM retail_sales GROUP BY category;
```

### 🔹 4️⃣ Average Age of Customers Buying 'Beauty' Products
```sql
SELECT ROUND(AVG(age), 2) AS avg_age FROM retail_sales WHERE category = 'Beauty';
```

### 🔹 5️⃣ Transactions with Total Sales > 1000
```sql
SELECT * FROM retail_sales WHERE total_sale > 1000;
```

### 🔹 6️⃣ Transactions by Gender & Category
```sql
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales GROUP BY category, gender ORDER BY category;
```

### 🔹 7️⃣ Best Selling Month Per Year
```sql
SELECT year, month, avg_sale FROM (
    SELECT EXTRACT(YEAR FROM sale_date) AS year,
           EXTRACT(MONTH FROM sale_date) AS month,
           AVG(total_sale) AS avg_sale,
           RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales GROUP BY 1, 2
) AS t1 WHERE rank = 1;
```

### 🔹 8️⃣ Top 5 Customers by Sales
```sql
SELECT customer_id, SUM(total_sale) AS total_sales FROM retail_sales GROUP BY customer_id ORDER BY total_sales DESC LIMIT 5;
```

### 🔹 9️⃣ Unique Customers per Category
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales GROUP BY category;
```

### 🔹 🔟 Sales Shifts (Morning, Afternoon, Evening)
```sql
WITH hourly_sale AS (
    SELECT *,
           CASE WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
                WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
                ELSE 'Evening' END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders FROM hourly_sale GROUP BY shift;
```

---

## 📌 Key Findings

📌 **Customer Demographics** – Sales data includes diverse age groups and categories.  
📌 **High-Value Transactions** – Many purchases exceed ₹1000, indicating premium customers.  
📌 **Sales Trends** – Identifying peak months helps forecast demand.  
📌 **Customer Insights** – Identifies top spenders and category popularity.

---

## 📑 Reports & Insights

📊 **Sales Summary** – Analyzing total sales, demographics, and category performance.  
📈 **Trend Analysis** – Monthly and shift-wise sales insights.  
🛍️ **Customer Insights** – Top customers and unique buyers per category.

---

## 🎓 Conclusion

This project provides a comprehensive SQL learning experience, covering:
✔️ Database setup  
✔️ Data cleaning  
✔️ Exploratory analysis  
✔️ Business-driven queries  

These insights can help businesses optimize their sales strategy and understand customer behavior.

---

## 🔧 How to Use

1️⃣ **Clone the Repository** – Copy the project from GitHub.  
2️⃣ **Set Up the Database** – Run the SQL scripts to create tables and import data.  
3️⃣ **Run the Queries** – Execute analysis queries in SQL.  
4️⃣ **Explore & Modify** – Customize queries for deeper insights!

---

## 📝 Author - RAVI YADAV

This project showcases SQL skills for aspiring data analysts. Connect with me for feedback or collaboration! 🚀

### 🌐 Stay Connected
  
💼 **LinkedIn** – [Professional networking](https://www.linkedin.com/in/raviyadav855)  

💡 **Thank you  Let's grow together!** 🚀
