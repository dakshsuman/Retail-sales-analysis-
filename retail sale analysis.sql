
	create database retail_sales;
use retail_sales;
'''sql 
select 
count(transaction_id)
from sales_analysis;
'''
'''sql 
select  * from sales_analysis
where sale_date = '05-11-2022';
'''
'''
select * from sales_analysis
where category = 'Clothing' 
and 
month(sale_date) = 11
and
year(sale_date) = 2022
and 
quantiy >= 1;
'''
'''
select * from sales_analysis
where category = 'Clothing'
and month(sale_date) = 11;
'''
'''sql 
SELECT * FROM sales_analysis
WHERE category = 'Clothing'
AND MONTH(sale_date) = 11
AND YEAR(sale_date) = 2022;
'''
'''
SELECT * FROM sales_analysis WHERE category = 'Clothing';

SELECT * FROM sales_analysis
WHERE category = 'Clothing'
AND STR_TO_DATE(sale_date, '%m-%d-%Y') BETWEEN '2022-11-01' AND '2022-11-30'
AND quantiy > 1;

'''





'''sql 
select *from sales_analysis
where gender = 'Male'
and age >= '35'
and str_to_date(sale_date, '%m-%d-%Y') between '2022-11-01' and '2022-11-30';
'''


'''
select * from sales_analysis
where price_per_unit>= 100
and total_sale >= 500
and str_to_date(sale_date, '%m-%d-%Y') between '2022-01-01' and '2023-12-31';
'''
'''sql
select category, sum(total_sale)
from sales_analysis
group by category;
'''
'''sql 	
select gender, sum(total_sale), count(*) as total_order
from sales_analysis
group by gender;
'''
	'''sql 
select round(avg(age),2), gender from sales_analysis
where category = 'Beauty'
group by gender;
'''
	'''sql 
select gender, category, count(transaction_id)
from sales_analysis
group by gender, category;
'''
#avg sales of each month with best month of year
'''sql 
with monthly_sales as (
select
Year(str_to_date(sale_date, '%m-%d-%Y')) as year,
Month(str_to_date(sale_date, '%m-%d-%Y')) as month,
round(avg(total_sale),2) as AVG_Sale_ofmonth
from sales_analysis
group by 1,2
)
select 
	year,
    month,
    AVG_Sale_ofmonth,
    rank() over ( partition by year order by Avg_Sale_ofmonth desc) as sales_rank
from monthly_sales
order by year, month ;

select customer_id, sum(total_sale) as total_sales
from sales_analysis
group by customer_id
order by total_sales desc limit 5;
'''
	'''sql 

select count(customer_id), category
from sales_analysis
group by category
order by 1;

with hourly_sales
as
(
 select*,
	case
		when extract(hour from sale_time ) < 12 then 'Morning'
        when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
    end as shift
from sales_analysis
)
select 
	shift, count(*) total_orders
from hourly_sales
group by shift
	'''
