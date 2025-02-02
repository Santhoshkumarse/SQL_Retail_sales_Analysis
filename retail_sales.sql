create database Retail_Sales_SQL;

USE Retail_Sales_SQL;

#Create Table
Create table retail_sales(
	transactions_id	int primary key,
	sale_date	date,
	sale_time	time,
	customer_id	int,
	gender	varchar(15),
	age	int,
	category	varchar(20),
	quantiy	int,
	price_per_unit	float,
	cogs	float,
	total_sale float
)

-- Data Cleaning
select * from retail_sales;

select count(*) from retail_sales 
where sale_date is null;

select count(*) from retail_sales 
where gender is null;

select count(*) from retail_sales 
where age is null;

select count(*) from retail_sales 
where category is null;

select count(*) from retail_sales 
where quantiy is null;

select count(*) from retail_sales 
where price_per_unit is null;

select count(*) from retail_sales 
where cogs is null;

select count(*) from retail_sales 
where total_sale is null;

#Delete 
delete from retail_sales
where sale_date is null
	OR
    transactions_id is null
    or
    sale_time is null
    or
    gender is null
    OR
    age is null
    or
    category is null
    or
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;
    
SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

-- Data Explorartion
-- How many sales we have?
select count(*) from retail_sales;

-- How many unique cutomers we have?
select count(distinct(customer_id)) from retail_sales;

-- Which are unique category we have?
select distinct(category) from retail_sales;
select * from retail_sales;

-- Data Analysis and Business Key problems and Answers
-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales
where sale_date = '2022-11-05';

/*Write a SQL query to retrieve all transactions where the category is 'Clothing' 
and the quantity sold is more than 4 in the month of Nov-2022:*/
select * from retail_sales
where category = 'Clothing' 
	and quantiy >= 4
    and date_format(sale_date,'%Y-%m') = '2022-11';

-- Write a SQL query to calculate the total sales (total_sale) for each category.:
select category, sum(total_sale) from retail_sales
group by category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select category,round(avg(age),2) from retail_sales 
where category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from retail_sales where total_sale > 1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select gender,category, count(*) as total_trans from retail_sales
group by category, gender
order by 2 ;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
    year_wise,
    month_wise,
    avg_sales
FROM (
    SELECT 
        YEAR(sale_date) AS year_wise,
        MONTH(sale_date) AS month_wise,
        AVG(total_sale) AS avg_sales,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS ranks
    FROM retail_sales 
    GROUP BY year_wise, month_wise
) AS ranked_data
WHERE ranks = 1;

select * from retail_sales;
-- **Write a SQL query to find the top 5 customers based on the highest total sales **:
select 
	customer_id,
    sum(total_sale) as max_sale_customer
from retail_sales
group by 1 
order by 2 desc
limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:
select 
	count(distinct(customer_id)) as uniq_customers ,
    category
from retail_sales
group by 2;
-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
select count(*) ,
    case 
		when hour(sale_time)<=12 then 'Morning'
        when hour(sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
	end as shift
from retail_sales
group by shift;
    
    
    



