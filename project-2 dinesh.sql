 use project2;

create table customers(customer_id int primary key,name varchar(100),email varchar(100),phone varchar(20),address varchar(255));

insert into customers(customer_id,name,email,phone,address)
values
(1,'john smith','john.smith@example.com','123-456-7890','123 main st,anytown,usa'),
(2,'alice brown','alice.brown@example.com','987-654-3210','456 oak st,anycity,usa'),
(3,'bob johnson','bob.johnson@example.com','555-123-4567','789 elm st,anyville,usa'),
(4,'emily davis','emily.davis@example.com','111-222-3333','456 maple st,anothercity,usa'),
(5,'michael wilson','michael.wilson@example.com','444-555-6666','789 pine st,anothertown,usa');

select * from customers;

create table Books(book_id int primary key,title nvarchar(100),author varchar(225),genre varchar(50),price decimal(10,2),quantity_avaliable int);

insert into Books(book_id,title,author,genre,price,quantity_avaliable)
values
(1,'To kill a mockingbird','Harper Lee','Fiction','15.99',50),
(2,'1984','george orwell','Fiction','12.99',30),
(3,'the great gatsby','F.scott fitzgerlad','Fiction','10.99',40),
(4,'pride and prejudice','jane austen','Romance','11.99',25),
(5,'the catcher in the rye','j.d.salinger','Fiction','14.49',20),
(6,'animal farm','george orwell','Fiction','11.49',35),
(7,'lord of the flies','william golding','Fiction','13.99',15),
(8,'1984','george orwell','Fiction','12.99',30),
(9,'romeo and juilet','william shakespeare','Romance','9.99',40),
(10,'the hobbit','j.r.r.tolkien','Fantasy','16.99',60);

select * from Books;

create table orders (order_id int primary key ,customer_id int,order_date date,total_amount decimal(10,2)
FOREIGN KEY(customer_id) REFERENCES customers(customer_id) );

insert into orders(order_id,customer_id,order_date,total_amount) 
values
(101,1,'2024-02-15',31.98),
(102,2,'2024-02-15',23.98),
(103,3,'2024-02-15',31.47),
(104,4,'2024-02-15',40.97),
(105,5,'2024-02-15',37.47),
(106,1,'2024-02-16',50.97),
(107,2,'2024-02-16',28.98),
(108,3,'2024-02-16',32.47),
(109,4,'2024-02-16',45.97),
(110,5,'2024-02-16',49.47);

select * from orders;

create table order_item(order_item_id int primary key,order_id int,book_id int,quantity int,subtotal decimal(10,2),
 FOREIGN KEY(order_id) References orders(order_id),
 FOREIGN KEY(book_id) References books(book_id));

insert into order_item(order_item_id,order_id,book_id,quantity,subtotal)
values
(1,101,1,2,'31.98'),
(2,102,2,1,'12.99'),
(3,102,3,1,'10.99'),
(4,103,4,1,'11.99'),
(5,103,5,3,'29.97'),
(6,104,6,2,'22.98'),
(7,104,7,1,'13.99'),
(8,105,8,2,'25.98'),
(9,105,9,1,'9.99'),
(10,106,10,3,'50.97');

select * from order_item;

select * from customers;
select * from Books;
select * from orders;
select * from order_item;

--1 Retrieve the total number of books available in the inventory.
SELECT SUM(quantity_avaliable) AS total_books_available FROM Books;

--2 List all books priced between $10 and $20.
select *
from Books
where Price between 10 AND 20;

--3 Display the top 10 bestselling books based on the number of copies sold.
SELECT Books.title, SUM(oi.quantity) AS total_sold FROM Books 
 INNER  JOIN order_item oi ON Books.book_id = oi.book_id
GROUP BY Books.title
ORDER BY total_sold DESC;

--4 Find the total revenue generated from book sales in the past month.
select sum(order_item.subtotal) as total_revenue from order_item 
 inner join orders on order_item.order_id = orders.order_id
where year(orders.order_date) = 2024
  and month(orders.order_date) = 2;

--5 List all customers who have placed orders in the last three months.
select distinct customer_id
from orders
where order_date >= dateadd(month, -3, getdate());

--6 Update the price of a specific book.
update Books set price = 100 where book_id=5; 
select * from Books;

--7 Remove a book from the inventory.
delete from Books where book_id = 5;

--8 Find the total number of orders placed by each customer.
select customer_id, count(*) AS totalOrders
from Orders
group by customer_id;

--9 Calculate the average order value.
select avg(total_amount) as average_order_value from orders;

--10 Display the details of orders containing more than five books.
select * from orders
where order_id in (select order_id from order_item group by order_id
 having count(*) > 5);

--11 List all books ordered by a specific customer.
select * from Books 

--12 Identify costomers who have not placed any orders.
select * from customers where customer_id not in (select distinct customer_id from orders);

--13 Retrieve the latest order for each customer.
select customer_id, max(order_date) as latest_order_date, order_id
from orders
group by customer_id, order_id;

--14 Calculate the total number of books sold in each genre.
select order_id, sum(quantity) as total_books_sold 
from order_item
group by order_id;

--15 Find the bestselling author based on total book sales.
select top 1 author, sum(quantity_avaliable) as total_books_sold
from books
group by author
order by total_books_sold desc ;

--16 Display the oldest and newest books in the inventory.

--oldest
SELECT top 1 *
FROM orders
ORDER BY order_date asc;
--newest
SELECT top 1 *
FROM orders
ORDER BY order_date desc;

--17 List all customers who reside in a particular city.
select * FROM customers
where address = '456 oak st,anycity,usa';

--18 Retrieve orders placed on a specific date.
select * from orders
where order_date = '2024-02-16';

--19 Find the average price of books in each genre.
select genre, avg(price) as averageprice
from books
group by genre;

--20 Identify duplicate entries in the Books table.
select title,author, count(*) from books
group by title,author 
having count(*)>1;

--21 Retrieve the most recent orders.
select top 10 * from orders
order by order_date desc;

--22 Calculate the total number of books sold each month.
select year(order_date) as year, month(order_date) as month, sum(quantity) as total_books_sold
from orders
inner join order_item on orders.order_id = order_item.order_id
group by year(order_date), month(order_date)
order by year, month;

--23 Display the top 5 customers with the highest total order amount.
select customers.customer_id,customers.Name, 
       sum(orders.total_amount) as total_order_amount
from customers
join orders on customers.customer_id = orders.customer_id
group by customers.customer_id, customers.name
order by total_order_amount desc;

--24 List all books with a quantity available less than 10.
select * from books
where quantity_avaliable< 10;

--25 Find orders with a total amount exceeding $100.
select * from orders
where total_amount > 100;

--26 Retrieve orders placed by a specific customer in the last week.
select * from orders where customer_id = (SELECT customer_id FROM customers 
WHERE name = 'John Smith') AND order_date >= dateadd(week, -1, getdate());

--27 Display the distribution of orders by month.
SELECT YEAR(order_date) AS order_year,MONTH(order_date) AS order_month,COUNT(*) AS order_count FROM  orders
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY order_year,order_month;

--28 Calculate the total revenue generated by each genre.
select genre,SUM(total_amount) as total_revenue from orders o
inner join order_item oi on o.order_id = oi.order_id
inner join Books b on oi.book_id = b.book_id
group by genre;

--29 List all customers who have spent more than $500 in total.
select c.customer_id,c.name,sum(o.total_amount) as total_spent from customers c
inner join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.name
having sum(o.total_amount) > 500;

--30 Find the customer who placed the earliest order.
SELECT  c.customer_id,c.name,SUM(o.total_amount) AS total_spent FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(o.total_amount) > 500;

--31 Display the average order value per month.
select year(order_date) as year,
       month(order_date) as month,
       avg(total_amount) as average_order_value
from orders
group by year(order_date), month(order_date)
order by year(order_date), month(order_date);

--32 Retrieve orders containing a specific book.
select o.order_id, o.customer_id, o.order_date, o.total_amount from orders o
 inner join order_item oi ON o.order_id = oi.order_id
inner join Books b ON oi.book_id = b.book_id
where b.title = 'to kill a mockingbird';

--33 Identify books that have never been ordered.
select books.*
from books
left join order_item on books.book_id = order_item.book_id
where order_item.book_id is null;

--34 Calculate the total number of orders placed each year.
select year(order_date) as year, count(*) as total_orders
from orders
group by year(order_date)
order by year;

--35 Find the total revenue generated by each customer.
SELECT customers.customer_id, customers.name, SUM(orders.total_amount) AS total_revenue FROM customers 
INNER JOIN orders  ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.name
ORDER BY total_revenue DESC;

--36 Display the distribution of book prices.
select count(*) as bookprices from books 
order by min(price);

--37 List all orders containing books authored by a specific author.
select distinct orders.* from orders 
left join order_item  on orders.order_id = order_item.order_id
left join books  on order_item.book_id = books.book_id
where books.author = 'george orwell';

--38 Retrieve orders placed within a specific time range.
select *
from orders
where order_date >= '2024-02-15' AND order_date <= '2024-02-16';

--39 Calculate the percentage of orders containing multiple books.
select count(*) as percentageoforders from order_item ;

--40 Find the customer who has placed the most orders.
SELECT top 1
  Customers.customer_id,
  Customers.name,
  count(orders.order_id) as total_orders
from
  customers
join
  orders on customers.customer_id = orders.customer_id
group by
  customers.customer_id, customers.Name
order by
  total_orders desc;

--41 Display the total number of books sold each day.
select o.order_date,sum(oi.quantity) as total_books_sold
from orders o 
join order_item oi on o.order_id = oi.order_id
group by o.order_date
order by o.order_date;

--42 List all customers who have placed orders for books in a specific genre.
SELECT DISTINCT c.customer_id, C.Name
FROM Customers c
JOIN Orders ON C.customer_id = Orders.customer_id
JOIN order_item ON Orders.order_id = order_item.order_id
JOIN Books ON order_item.book_id = books.book_id
WHERE Books.Genre = 'romance';

--43 Retrieve orders with a total amount within a certain range.
select *
from orders
where total_amount BETWEEN 30.00 AND 50.00;

--44 Find the book with the highest price.
select * from books where price=(select max(price) from books);

--45 Calculate the average quantity of books ordered per customer.
SELECT AVG(total_amount) AS average_quantity_per_customer FROM orders;

--46 Identify customers who have placed orders for the same book multiple times.
select order_id
from order_item
group by order_id, book_id
having count(*) > 1;

--47 Retrieve orders containing books priced above the average price.
select orders.* from orders  
inner join order_item oi on orders.order_id = oi.order_id
inner join books b on oi.book_id = b.book_id
where b.price > (select avg(price) from books);

--48 Display the total number of orders placed on weekdays vs. weekends. 
select count(*) as num_orders
from orders
group by case when datepart(weekday, order_date) in (1,7) then 'Weekend' else 'Weekday' end;

--49 Find the customer who has ordered the most expensive book.
select top 1 customers.customer_id, customers.name from customers 
join orders o on customers.customer_id = o.customer_id
join order_item oi on o.order_id = oi.order_id
join books b on oi.book_id = b.book_id
order by b.price desc;

--50 Retrieve orders containing books published in a specific year.
select orders.*
from orders 
join order_item oi on orders.order_id = oi.order_id
join books b on oi.book_id = b.book_id
where b.title like '2024';

--51 Find the total number of unique customers who have placed orders.
select count(distinct customer_id) as total_Unique_customers
from orders;

--52 Retrieve orders with a total amount less than $50.
select *
from orders
where total_amount < 50;

--53 Display the top 10 customers who have purchased the most books.
select top 10 customers.customer_id, customers.name, count(order_item.order_item_id) as num_books_purchased
from customers 
inner join orders on customers.customer_id = orders.customer_id
inner join order_item on orders.order_id = order_item.order_id
group by customers.customer_id, customers.name
order by num_books_purchased desc;

--54 List all books ordered in descending order of their price.
select * from books
order by Price desc;

--55 Calculate the total revenue generated from book sales in the past year.
SELECT SUM(Total_Amount) AS Total_Revenue
FROM orders
WHERE order_date >= dateadd(year, -1, getdate());

--56 Find the total number of orders placed on each day of the week.
select datepart(weekday, order_date) as day_of_week, count(*) as num_orders from orders
group by datepart(weekday, order_date);

--57 Retrieve orders containing books with titles containing a specific keyword.
select orders.* from orders 
join order_item ON orders.order_id = order_item.order_id
join books b ON order_item.book_id = b.book_id
where b.title LIKE '%1984%';

--58 Identify customers who have placed orders in consecutive months.
select distinct customers.customer_id from  orders
inner join orders o2  on orders.customer_id = orders.customer_id 
inner join customers  on orders.customer_id = customers.customer_id
order by customers.customer_id;

--59 Calculate the total profit margin (revenue minus cost) for each book.
SELECT Books.book_id,Books.title,
sum((order_item.quantity * Books.price) - (order_item.quantity * Books.price)) as profit_margin from Books 
inner join order_item on Books.book_id = order_item.book_id
group by Books.book_id, Books.title;

--60 List all customers who have placed orders for books of multiple genres.
select distinct customers.customer_id, customers.name from customers 
inner join orders  ON customers.customer_id = orders.customer_id
inner join order_item  ON orders.order_id = order_item.order_id
inner join Books  ON order_item.book_id = Books.book_id
group by customers.customer_id, customers.name
having count(distinct Books.genre) > 1;

--61 Find orders with a total amount less than the average order value.
SELECT *
FROM Orders
WHERE total_amount < (
  SELECT AVG(total_amount)
  FROM Orders);

--62 Retrieve the oldest order placed by each customer.
SELECT
  Customers.customer_id,
  Customers.Name,
  MIN(Orders.order_date) AS OldestOrderDate
FROM
  Customers
JOIN
  Orders ON Customers.customer_id = Orders.customer_id
GROUP BY
  Customers.customer_id, Customers.Name;

--63 Display the distribution of book prices within each genre.
SELECT Genre, AVG(Price) AS AveragePrice, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Books GROUP BY Genre ORDER BY Genre;

--64 Calculate the total quantity of each book sold.
SELECT Books.book_id, Books.Title,
 SUM(order_item.Quantity) AS TotalQuantitySold
FROM Books
JOIN order_item ON Books.book_id = order_item.book_id
GROUP BY Books.book_id, Books.Title
ORDER BY TotalQuantitySold DESC;

--65 List all customers who have placed orders for books authored by a specific author.
SELECT DISTINCT Customers.customer_id, Customers.Name
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id
JOIN order_item ON Orders.order_id = order_item.order_id
JOIN Books ON order_item.book_id = Books.book_id
WHERE books.Author = 'Jane Austen';

--66 Find the total number of orders placed in each city.
SELECT address, COUNT(*) AS TotalOrders
FROM customers
GROUP BY address
ORDER BY TotalOrders DESC;

--67 Retrieve orders containing books with prices ending in ".99".
select distinct orders.order_id, orders.order_date
from orders
join order_item on orders.order_id = order_item.order_id
join books ON order_item.book_id = Books.book_id
where books.Price LIKE '%.99';

--68 Identify customers who have placed orders for books published in a specific decade.
select distinct c.customer_id, c.name from customers c
inner join orders o on c.customer_id = o.customer_id
inner join books b on o.order_id= b.book_id
where b.title = 'To Kill a Mockingbird';

--69 Calculate the average number of books ordered per order.
select avg(quantity) as averagebooksorderedperorder
from order_item;

--70 Retrieve orders placed by customers who have not provided their phone numbers.
alter table customers
add phone_number varchar(20); 
select * from customers;

select orders.* from orders 
left join customers on orders.customer_id = customers.customer_id
where customers.phone_number is null;









































