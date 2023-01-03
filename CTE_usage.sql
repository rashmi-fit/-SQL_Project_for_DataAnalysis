--find stores who's sales were better than the avg sales across all stores

--find total sales
--find avg sales across all sales across stores
--find the stores where total sales> avg sales


create table sale(
 store_id int
 , store_name varchar(20)
 ,product varchar(20)
 ,quantity int
 ,cost int
);

insert into sale values(1,'Apple originals', 'iphone 13', 1, 1000)

insert into sale values(1,'Apple originals', 'iphone 11', 3, 2000)

insert into sale values(2,'Apple originals', 'iphone 12', 2, 280)
insert into sale values(2,'Apple originals', 'iphone 12 pro', 1, 1000)
insert into sale values(3,'Apple originals', 'iphone 11', 1, 1000)
insert into sale values(4,'Apple originals', 'Mac book', 3, 1000)

select * from sale

--below is so confusing

select * from
(
select s.store_id, sum(cost) as total_sales_per_Store
 from sale s
group by 1) total_sales

join

(select cast(avg(total_sales_per_Store) as int) as avg_sales_for_all_stores
from 
(select s.store_id, sum(cost) as total_sales_per_Store
 from sale s
group by 1)) avg_sales

on total_sales.total_sales_per_Store >avg_sales.avg_sales_for_all_stores


--lets use cte

with total_sales AS 
(select s.store_id, sum(cost) as total_sales_per_Store
 from sale s
group by 1) ,

avg_sales_for_all_stores AS 
(select cast(avg(total_sales_per_Store) as int) as avg_sales_for_all_stores
from total_sales) 

select * from total_sales
join avg_sales_for_all_stores
on total_sales_per_Store > avg_sales_for_all_stores

