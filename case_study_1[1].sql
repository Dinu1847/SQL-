create database casestudy;
use casestudy;
create table Departments(Department_ID int primary key,Departmentname varchar(30),Manager_ID int,Location varchar(30));
INSERT INTO Departments (Department_ID, Departmentname, Manager_ID, Location)

VALUES (1, 'HR', 101, 'Headquarters'),

       (2, 'IT', 201, 'Tech Park'),

       (3, 'Finance', 301, 'Downtown');

select * from Departments;


 create table Employees(EmployeeID int primary key,Firstname varchar(20),Lastname varchar(20),DateofBirth date,gender varchar(10),postion varchar(30),Department_ID int,DateOfJoining date);
 INSERT INTO Employees (EmployeeID, FirstName, LastName, DateOfBirth, Gender,postion,Department_ID, DateOfJoining)

VALUES (101, 'John', 'Doe', '1985-05-15', 'M', 'HR Manager', 1, '2010-01-15'),

       (102, 'Jane', 'Smith', '1990-08-22', 'F', 'Software Engineer', 2, '2015-03-10'),

       (103, 'Bob', 'Johnson', '1982-11-10', 'M', 'Accountant', 3, '2018-07-05');

select * from Employees;	
select * from Departments;
drop table departments;
drop table ;

select * from Employees where Department_id=(select Department_ID from  Departments where Departmentname = 'IT');


UPDATE employees SET postion = 'Senior HR Manager'  WHERE EmployeeID = 101;  
select * from Employees;



select Departmentname, Location,EmployeeID  from Departments d cross join Employees e where e.EmployeeID=102;

SELECT *
FROM employees
WHERE DateOfJoining > '2015';
