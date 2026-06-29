use retail_store;
select * from customers;
select * from orders;
select * from products;

select CustomerName,City from customers;

select CustomerName,City from customers
where City = 'Mumbai';

select ProductName,Category from products
where Category = 'Electronics';

select ProductName,Price from products
where Price > 10000;

select OrderID,OrderDate from orders
where OrderDate > 2024-04-01;

select OrderID,Quantity from orders
where Quantity > 2;

select distinct(Category) from  products;

select CustomerName from customers
where CustomerName like 'A%'; 

select CustomerName,SignupDate from customers
where SignupDate > 2023-06-01;

select ProductName, Price from products
order by Price desc;

select ProductName, Price from products
order by Price desc
limit  5;

select ProductName, Price from products
where Price   between 3000 and 10000;

----------------

select count(*) tot_cus from customers;

select City,count(*) tot_cus from customers
group by City;

select Category,count(*)  pro_count from products
group by Category;

select sum(Quantity) tot_quan_sold from orders;

select ProductName,round(AVG(Price),2) as avg_price from products
group by ProductName;

select ProductName,Price from products
order by Price desc
limit 1;

select ProductName,Price from products
order by Price asc
limit 1;

select p.ProductName,SUM(Quantity) as quant_sold from products  p
join orders o
on o.ProductID = p.ProductID
group by p.ProductName;

select * from orders;
select * from products;

select p.ProductName,SUM(Quantity* Price) as revenue from products  p
join orders o
on o.ProductID = p.ProductID
group by p.ProductName
order by revenue desc;

select p.Category,sum(Quantity*Price) as revenue  from products  p
join orders o
on o.ProductID = p.ProductID
group by p.Category
order by revenue desc;

select p.Category,sum(Quantity*Price) as revenue  from products  p
join orders o
on o.ProductID = p.ProductID
group by p.Category
having revenue > 50000;

select p.ProductName,SUM(Quantity) as quant_sold from products  p
join orders o
on o.ProductID = p.ProductID
group by p.ProductName
having quant_sold > 5;

select o.OrderID,sum(o.Quantity* p.Price) as revenue from orders o
join products p
on p.ProductID = o.ProductID 
group by o.OrderID
order by revenue desc;


select c.City,sum(Quantity) as quan_sold from customers c
join orders o
on o.CustomerID =c.CustomerID
group by c.City
having quan_sold >1;

------------------------------------------
select * from customers;
select * from orders;
select * from products;

select c.CustomerName,p.ProductName, sum(o.Quantity) quantity ,sum(p.Price) prices from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on o.ProductID = p.ProductID
group by c.CustomerName,p.ProductName;

select c.CustomerName,sum(o.Quantity*p.Price) cus_spent from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on o.ProductID = p.ProductID
group by c.CustomerName
order by cus_spent desc;

select c.CustomerName,sum(o.Quantity*p.Price) cus_spent from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on o.ProductID = p.ProductID
group by c.CustomerName
order by cus_spent desc
limit 5;

select c.CustomerName, count(o.orderID) orders_placed from customers c
join orders o
on c.CustomerID = o.CustomerID
group by c.CustomerName
having orders_placed = 0;


select p.ProductName, count(o.orderID) orders_placed from products p
join orders o
on p.ProductID = o.ProductID
group by p.ProductName
having orders_placed = 0;

select c.CustomerName, count(o.orderID) orders_placed from customers c
join orders o
on c.CustomerID = o.CustomerID
group by c.CustomerName;


select c.CustomerName, min(OrderDate) frst_orders_date,max(OrderDate) last_order_date from customers c
join orders o
on c.CustomerID = o.CustomerID
group by c.CustomerName;

select c.City, sum(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by c.City
order by reven desc;


select p.Category, sum(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by p.Category
order by reven desc;

select p.ProductName, sum(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by p.ProductName
order by reven desc;

select c.Gender, avg(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by c.Gender
order by reven desc;

select c.CustomerName from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
where p.Category = 'Electronics'
group by c.CustomerName;

-----------------------------------------
select * from customers;
select * from orders;
select * from products;

select OrderID,row_number()over(order by OrderID asc) as ranks  from orders;


with cte as 
(
select p.ProductName,sum(p.Price *o.Quantity) as pro_rev from products p
join orders o
on o.ProductID = p.ProductID
group by p.ProductName
)
select *,rank()over(order by pro_rev desc) as ranks from cte;

with cte as 
(
select c.CustomerName,sum(p.Price *o.Quantity) as pro_rev from products p
join orders o
on o.ProductID = p.ProductID
join customers c
on c.CustomerID = o.CustomerID
group by c.CustomerName
)
select *,dense_rank()over(order by pro_rev desc) as ranks from cte;

with cte as 
(
select c.CustomerName,sum(p.Price *o.Quantity) as cus_rev from products p
join orders o
on o.ProductID = p.ProductID
join customers c
on c.CustomerID = o.CustomerID
group by c.CustomerName
)
,cte2 as 
(
select *, dense_rank()over(order by cus_rev desc) ranks from cte
)
select * from cte2
where ranks = 2;


with cte as
(
select p.ProductName,sum(p.Price *o.Quantity) as pro_rev from products p
join orders o
on o.ProductID = p.ProductID
join customers c
on c.CustomerID = o.CustomerID
group by p.ProductName
)
,cte2 as
(
select *,dense_rank()over(order by pro_rev desc) as ranks from cte
)
select * from cte2
where ranks = 3;



with cte as
(
select p.ProductName,p.Category,sum(p.Price *o.Quantity) as pro_rev from products p
join orders o
on o.ProductID = p.ProductID
join customers c
on c.CustomerID = o.CustomerID
group by p.Category,p.ProductName
)
,cte2 as
(
select *,dense_rank()over(partition by Category order by pro_rev desc) as ranks from cte
)
select * from cte2
where ranks <=2;

with cte  as 
(
select o.OrderDate,sum(p.Price *o.Quantity) as pro_rev from products p
join orders o
on o.ProductID = p.ProductID
join customers c
on c.CustomerID = o.CustomerID
group by o.OrderDate
)
select *,sum(pro_rev)over(order by OrderDate)  as run_tot from cte;

with cte  as 
(
select c.CustomerName,sum(p.Price *o.Quantity) as pro_rev from products p
join orders o
on o.ProductID = p.ProductID
join customers c
on c.CustomerID = o.CustomerID
group by c.CustomerName
)
select *,sum(pro_rev)over(order by CustomerName)  as run_tot from cte;

with cte as (

select o.OrderID, O.Quantity quan,p.Price pri,p.Category from orders o
join products p 
on p.ProductID = o.ProductID
)
select OrderID,sum(c.quan*c.pri) as cat_rev from cte c
group by Category;


select o.OrderID,o.Quantity,lag(Quantity)over(order by o.Quantity ) prev from orders o;

select o.OrderID,o.Quantity,lead(Quantity)over(order by o.Quantity ) nezxt_order_quan from orders o;

select o.OrderID,o.Quantity,lag(Quantity)over(order by o.Quantity), 
(o.Quantity-lag(Quantity)over(order by o.Quantity)) diff  from orders o;

select OrderID,OrderDate,lag(OrderDate)over(order by OrderDate) as prev_Order_date from orders;


select OrderID,OrderDate,lag(OrderDate)over(order by OrderDate) as prev_Order_date,
DATEDIFF(OrderDate,lag(OrderDate)over(order by OrderDate)) dif 
from orders;
--------------------
select c.CustomerName, sum(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by c.CustomerName
order by reven desc
limit 1;


select p.ProductName, sum(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by p.ProductName
order by reven desc
limit 1;

select p.Category, sum(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by p.Category
order by reven desc
limit 1;

select c.City, sum(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by c.City
order by reven desc
limit 1;

select MONTH(o.OrderDate), sum(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by MONTH(o.OrderDate)
order by reven desc
limit 1;

select MONTH(o.OrderDate), sum(o.Quantity) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by MONTH(o.OrderDate)
order by reven desc
limit 1;

select c.CustomerName, COUNT(o.OrderID) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by c.CustomerName
order by reven desc;


select c.CustomerName, COUNT(o.OrderID) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by c.CustomerName
having reven = 1
order by reven desc;


with cte as 
(
select c.CustomerName, sum(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by c.CustomerName
)
select CustomerName,reven,round((reven *100 /(select sum(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID)),2) contri from cte;


with cte as 
(
select p.Category, sum(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by p.Category
)
select Category,reven,round((reven *100 /(select sum(o.Quantity*p.Price) as reven from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID)),2) contri from cte;


select c.CustomerName, count(p.Category) cat_count from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
group by c.CustomerName
having cat_count>1;

select c.CustomerName, count(p.ProductName) pro_count from customers c
join orders o
on c.CustomerID = o.CustomerID
join products p
on p.ProductID = o.ProductID
where p.Category = 'Fashion'
group by c.CustomerName
having pro_count = (select count(ProductName) pro_count from products
where Category = 'Fashion');


select c.CustomerName,o.OrderID,o.OrderDate,lag(o.OrderDate)over(order by o.OrderDate) as prev_Order_date,
DATEDIFF(o.OrderDate,lag(o.OrderDate)over( order by o.OrderDate)) dif 
from orders o 
join customers c
on c.CustomerID = o.CustomerID;


with cte as 
(
select c.CustomerName,o.OrderDate,lag(o.OrderDate)over( order by o.OrderDate) as prev_order_date,
DATEDIFF(o.OrderDate,lag(o.OrderDate)over( order by o.OrderDate)) as diff_days
from orders o 
join customers c
on c.CustomerID = o.CustomerID
)
select CustomerName, ceil(avg(diff_days)) from cte
group by CustomerName












select * from customers




