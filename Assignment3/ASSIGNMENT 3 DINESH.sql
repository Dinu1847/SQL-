use dataanalytics
---1
 Create table customers( customer_number int,first_name varchar(30),last_name varchar(20));
 Insert into customers(customer_number,first_name,Last_name) values 
   (001,'Jane','Doe'),
   (002,'John','Doe'),
   (003,'Jane','Smith'),
   (004,'John','Smith'),
   (005,'Jane','Jones'),
   (006,'John','Jones');

 Select * from customers;

 Create table orders(order_number int,customer_number int,order_date date,order_total decimal(8,2));
 Insert into orders(order_number,customer_number,order_date,order_total) values
    (1001,2,'2009-10-10',250.85),
    (1002,2,'2010-02-21',125.89),
    (1003,3,'2019-11-15',1567.99),
    (1004,4,'2009-11-22',180.92),
    (1005,4,'2009-12-15',565.00),
    (1006,6,'2009-11-22',25.00),
    (1007,6,'2009-10-08',85.00),
    (1008,6,'2009-12-29',109.12);
 Select * from orders;

 Select * from customers;
 Select * from orders;

 --2

  Select *  from customers inner join orders on customers.customer_number=orders.customer_number;

  --3

  Select *  from customers left join orders on customers.customer_number=orders.customer_number;
  Select *  from customers right join orders on customers.customer_number=orders.customer_number;
  
  --4

  Update orders set customer_number=100 where customer_number=3; 
  Select * from orders;

  --5

  Alter  table customers add Email varchar(40);  
  Select * from customers;
  Update customers set Email='jhonsmith123@gmail.com' where customer_number=4;
  Update customers set Email='janedoe@gmail.com' where customer_number=1;
  Select * from customers;

  --6

 Select * from Customers  self join customers  on customers.Customer_number= customers.Customer_number; 

 --7

 delete from orders 
 where not exists(select 1 from customers where customers.customer_number=orders.customer_number);
 select * from orders;
 delete from orders 
 where not exists(select 3 from customers where customers.customer_number=orders.customer_number);
  select * from orders;

  --8
  
  alter table orders 
  add  order_status varchar(30)default ('pending')not null;
    select * from orders;
	
  --9

alter table customers
add country varchar(30) default('unknown')not null;
select * from customers;

--10

select avg(order_total) from orders;

--11

alter table orders
add constraint fk_orders_customers
foreign key (customer_number)
references customers(customer_number);
select * from orders;

--12

select customers.first_name,customers.last_name
from customers left join orders on customers.customer_number = orders.customer_number 
where orders.customer_number is null;

--13

select count(distinct first_name) as numberofffirst_name
from customers;
select count(distinct last_name) as numberofflast_name
from customers;

--14

from delete statement we can delete column in the delete
delete from orders where order_number=1005;
select * from orders;

--15

alter table orders
add production varchar(500);
select * from orders;

--16

select customer_number,sum(order_total) as total_spent
from orders group by customer_number order by total_spent desc;

--24

 Select Order_number, min(order_date) from orders;

--17

By describing an default value of order status (Pending) shows the status of the customer who order is still
pending .If the order status doesn't contain any value it defaultly shows the value like pending.--18Updating information in the column which is common for both tables , like in the above tables we have
customer_number common if we update customer_number the information is updated.

--19

Ex: Select Customer_number from Orders group by customers;

--20

when we are performing leftjoin between customers and order all the record in the customers table appears
with join of orders table, but on order table some values appears as NULL.

--21

The Purpose of the Group by clause in SQL is, it will help to applying the Aggregation functions to the group of
rows of the same kind.

--22

Having clause is used for the group by functions, where it helps in defining filters on the grouped query based
on the aggregation function.
Where clause is used to filter specific rows based on certain condition while having clause is used to filter group of
rows where the query based on conditions involving aggregated values.

--23

In orders table the primary key is used for order_numb where the primary key does not allows the duplicate
values in rows in the table. It has different unique values for each row in the table.--25Indexes helps us to retrieve the data from table quickers.
With proper index in place, the database system can then first go through the index to find out where to retrieve the
data, and then go to these locations directly to get the needed data.




 