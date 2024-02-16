use krish;

create table passenger(passenger_id int primary key,name varchar(50),contact_number varchar(30),email varchar(100));
insert into passenger(passenger_id,name,contact_number,email) values (1,'john doe','123-456-7890','john.doe@example.com'),
(2,'jane smith','987-654-3210','jane.smith@example.com'),
(3,'michael brown','555-123-4567','michael.brown@example.com'),
(4,'emily johnson','222-333-4444','emily.johnson@example.com'),
(5,'david wilson','999-888-777','david.wilson@example.com'),
(6,'sarah lee','777-666-5555','sarah.lee@example.com'),
(7,'james miller','111-222-3333','james.miller@example.com'),
(8,'lisa taylor','444-555-6666','lisa.taylor@example.com'),
(9,'robert anderson','777-888-9999','robert.anderson@example.com'),
(10,'olivia martinez','666-555-4444','olivia martinez@example.com');
select * from passenger;

create table busfares(fare_id int primary key,fare_type varchar(40),price decimal(10,2),discounts nvarchar(50));
insert into busfares(fare_id,fare_type,price,discounts) values
(1,'sitting',50.00,'10% off for seniors'),
(2,'sleeper',100.00,'20% off for students');
select * from busfares;

create table bookings(booking_id int primary key,passenger_id int,fare_id int,seat_number int,payment_status varchar(50),
Foreign key (passenger_id) references passenger(passenger_id),
foreign key(fare_id) references Busfares(fare_id),
constraint unique_seat_per_booking unique (booking_id,seat_number),
constraint valid_payment_status check (payment_status in ('paid','pending')));
insert into bookings(booking_id,passenger_id,fare_id,seat_number,payment_status) values
(1,1,1,10,'paid'),
(2,2,1,15,'pending'),
(3,3,2,5,'paid'),
(4,4,2,12,'paid'),
(5,5,1,8,'pending'),
(6,6,1,20,'paid'),
(7,7,2,3,'paid'),
(8,8,1,16,'pending'),
(9,9,2,7,'paid'),
(10,10,1,4,'pending');
select * from bookings;
select * from passenger;
select * from busfares;

select name,payment_status  from passenger inner join bookings on passenger.passenger_id=bookings.passenger_id where payment_status='pending';

select passenger.name from passenger inner join bookings on passenger.passenger_id=bookings.passenger_id where payment_status='pending';

select busfares.fare_type from busfares inner join bookings on busfares.fare_id=bookings.fare_id;

select fare_id, count(*) as total_bookings from bookings group by fare_id;

update bookings set payment_status='paid' where booking_id=2;
select * from bookings;

select sum(fare_id) as total_revenue from bookings where payment_status='paid';

select sum(fare_id) as total_revenue from bookings where payment_status='pending';

select passenger.* from passenger join bookings ON passenger.passenger_id = bookings.passenger_id where bookings.fare_id=1;

delete from bookings where passenger_id=3;
select * from bookings;

select  Bookings.booking_id, Passenger.name AS passenger_name, Passenger.contact_number, Passenger.email, BusFares.fare_type, BusFares.price, BusFares.discounts, Bookings.seat_number,  Bookings.payment_status
from Bookings join Passenger ON Bookings.passenger_id = Passenger.passenger_id join BusFares ON Bookings.fare_id = BusFares.fare_id;

select count(*) as total_bookings from bookings where booking_id=2;

select passenger.* from passenger inner join bookings on passenger.passenger_id=bookings.passenger_id where seat_number=10;

select BusFares.*from BusFares join bookings ON BusFares.fare_id = bookings.fare_id where bookings.booking_id = 9;

select fare_type, avg(price) AS average_price from Busfares group by fare_type;

select Passenger.* from passenger inner join ( select passenger_id from bookings group by passenger_id having count(*)>1)
 AS bookings ON passenger.passenger_id = Bookings.passenger_id;

SELECT busfares.fare_type, COUNT(Bookings.booking_id) AS booking_count FROM busfares LEFT JOIN Bookings ON busfares.fare_id = Bookings.fare_id GROUP BY busfares.fare_type;

select fare_id, count(*) as booking_count from bookings group by fare_id;

select * from bookings where seat_number between 1 and 10;

select * from passenger where passenger_id in (select booking_id from bookings where payment_status = 'pending');


