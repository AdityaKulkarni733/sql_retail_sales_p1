-- SQL Retail sale analysis - p1


-- create talbes

create table retail_sales
			(
				transactions_id int primary key,
				sale_date date,
				sale_time time,
				customer_id	int,
				gender varchar(15),
				age int,
				category varchar(25),	
				quantiy	int,
				price_per_unit float,
				cogs float,
				total_sale float
			);

select * from retail_sales
limit 10;

select count(*) from retail_sales

--
select * from retail_sales
where transactions_id is null

select * from retail_sales
where sale_date is null

select * from retail_sales
where sale_time is null

select * from retail_sales
where 
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	gender is null
	or
	customer_id is null
	or 
	age is null
	or
	category is null
	or
	quanti

	DELETE FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales



SELECT DISTINCT category FROM retail_sales

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select *
from retail_sales
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is
--'Clothing' and the quantity sold is more than or equal to 4  in the month of Nov-2022

select *
	from retail_sales
	where category = 'Clothing'
	and
	to_char(sale_date, 'YYYY-MM') = '2022-11'
	and
	quantity>=4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select 
	category,
	sum(total_sale) as Net_Sales,
	count (*) as total_orders
	from retail_sales
	group by 1
	
-- Q.4 Write a SQL query to find the average age of 
--customers who purchased items from the 'Beauty' category.

select round (avg(age),2) 
	 from retail_sales
	 where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * 
	from retail_sales
	where total_sale>1000

-- Q.6 Write a SQL query to find the total number of transactions
--(transaction_id) made by each gender in each category.

select
	category,
	gender,
	count(*) as total_trans
	from retail_sales
	group by category,
			 gender
			 order by 1

-- Q.7 Write a SQL query to calculate the average sale for each month. 
--Find out best selling month in each year

select 
	year,
	month,
	avg_sales
from
(
	select
		extract(year from sale_date) as Year,
		extract(month from sale_date) as Month,
		avg(total_sale) as avg_sales,
		rank() over (partition by extract(year from sale_date) order by avg(total_sale) desc) as Rank
		from retail_sales
		group by 1,2
	--	order by 1,3 desc
) as t1
where rank = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select 
	customer_id,
	sum(total_sale) as Total_Sale
	from retail_sales
	group by 1
	order by 2 desc
	limit 5

-- Q.9 Write a SQL query to find the number of 
--unique customers who purchased items from each category.

select 
	category,
	count (distinct customer_id) as Count_of_unique_cust
	from retail_sales
	group by 1

-- Q.10 Write a SQL query to create each shift and number of orders 
--(Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sales
as
(
select *,
	case 
		when extract(hour from sale_time) < 12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift
	from retail_sales
	)
	select * from hourly_sales