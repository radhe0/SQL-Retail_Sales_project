select * from retail_sales;

-- lets check we have full data 
-- select count(*)
-- from retail_sales;


-- ## DATA CLEANING


-- checking any coloumn have null values or not

select * from retail_sales
where transactions_id is null
	or sale_date is null
	or sale_time is null
	or customer_id is null
	or gender is null
	or age is null 
	or category is null
	or quantiTy is null
	or price_per_unit is null
	or cogs is null
	or total_sale is null;

-- -- renamed mispelled coloumn
-- alter table retail_sales
-- rename column quantiy to quantity;



-- lets now clean the data by handle missing values 
-- first we fill age null value with the average of age , so 

update retail_sales
set age = (select avg(age) from retail_sales) where age is null;


-- lets now remove some rows which is null in field quantity , price_per_unit,cogs,total_sale

delete from retail_sales
where quantity is null
	or price_per_unit is null
	or cogs is null
	or total_sale is null;


-- now again check any field have null values or not . 
select * from retail_sales
where transactions_id is null
	or sale_date is null
	or sale_time is null
	or customer_id is null
	or gender is null
	or age is null 
	or category is null
	or quantiTy is null
	or price_per_unit is null
	or cogs is null
	or total_sale is null;




-- DATA EXPLORATION

-- How many sales we have ?

select count(*) from retail_sales;
-- = 1997

select * from retail_sales;

-- now how many unique customer we have ?
select count(distinct(customer_id)) from retail_sales;
-- = 155

-- How many category we have ?
select distinct(category) from retail_sales;

-- = Electronics,Clothing,Beauty

-- Total quantity sold 
select sum(quantity) from retail_sales;
-- = 5018



-- Total Sales done 
select sum(total_sale) from retail_sales;
-- = 911720

-- who have done more shopping male or female 
select gender,sum(quantity),sum(total_sale) from retail_sales
group by gender;
-- = Female with quantity(2586) with total_sales 465400



-- which category have highest sale 
select category , sum(quantity),sum(total_sale)
from retail_sales
group by category;
-- electronics have highest sale , while , clothing has highest quantity.


-- which category has highest price per unit 
select category , max(price_per_unit)
from retail_sales
group by category;
-- all have highest same price 500



-- which category sold highest quantity
select category , sum(quantity) 
from retail_sales
group by category;
-- cloting has sold highest quantity = 1785



-- main data analysis business problem 

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales
where sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

select *
from retail_sales
where category = 'Clothing'
	and to_char(sale_date,'YYYY-MM') = '2022-11'
	and quantity >= 4
	
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category ,
	sum(total_sale) total_sales,
	count(*) total_orders
from retail_sales
group by category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),2) as avg_age
from retail_sales
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
from retail_sales
where total_sale > 1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select gender,category,count(transactions_id) 
from retail_sales
group by gender ,category;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select sale_date,round(avg(total_sale),2) as Average_sale
from retail_sales
group by sale_date
order by Average_sale desc limit 2;

select *
from( 
	select
		extract(year from sale_date) as Sale_year, 
		extract(month from sale_date) as Sale_Month,
		round(avg(total_sale),2) average_sale,
		rank() over (partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
	from retail_sales
	group by Sale_year,Sale_month
	) as t1
where rank = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,sum(total_sale) total_sale
from retail_sales
group by customer_id
order by total_sale desc 
limit 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct(customer_id))
from retail_sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)


with hourly_sales
as
(
select * ,
	case
		when extract(hour from sale_time) < 12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift
from retail_sales
)
select shift,count(*) from hourly_sales
group by shift;