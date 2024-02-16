use dataanalytics;

--1 Table Creation and insertion

create table students(Student_id varchar(30),name varchar(40), age int,gpa decimal(3,1));

insert into students(student_id,name,age,gpa)
values
('203n1a0418','dinesh',21,7.5),
('203n1a0450','venu',20,7.0),
('203n1a0405','vijay',21,7.0),
('203n1a0429','tharun',20,7.4),
('203n1a0430','sharath',22,6.9),
('203n1a0447','mohammad',21,8.0),
('203n1a0417','sujan',20,6.9);

select * from students;

--2 Simple Queries

select * from students where gpa > 3.5;

select name,age from students where age < 20;

--3 Sorting and limiting results
 
select top 3 name,gpa from students order by GPA desc;

select name,age from students order by age asc;

--4 Multiple tables

create table courses1 (course_id int primary key,course_name varchar(20),student_id varchar(30));
drop table courses1;
insert into courses1(course_id,course_name,student_id) 
values
(1,'ece','203n1a0418'),
(2,'ece','203n1a0450'),
(3,'ml','203n1a0405'),
(4,'eee','203n1a0429'),
(5,'eee','203n1a0430'),
(6,'ece','203n1a0447'),
(7,'ml','203n1a0417');

select * from courses1;
select * from students;

--5 inner join

select * from students inner join courses1 on students.Student_id=courses1.student_id;

--6 Left and Right joins

If all students are enrolled in atleast one course

--7 Agrregation and Grouping

select age,count(*) from students group by age;

select course_name,count(*) from courses1 group by course_name;


--8 Aggregation functions

select avg(gpa) from students;

select max(age) from students;

--9 Subqueries

select name,gpa from students where gpa >(select avg(gpa) from students);

select top 3 student_id,course_name from courses1 order by course_name;



