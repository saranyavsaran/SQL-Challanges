-- 1. CREATE Table
-- Scenario:
--  You are a data analyst at City Hospital. Management wants to create a new table to store patient details.
-- Task:
--  Write a SQL command to create a table named Patients with fields (PatientID, PatientName, Age, Gender, AdmissionDate).
Create database if not exists HospitalDb;
use HospitalDb;
create table if not exists patients(
patientid int primary key auto_increment,
patient_name varchar(20),
age int,
Gender enum("Male","Female"),
Admissiondate Date
);

-- 2) ALTER – Add Column
-- Scenario:
--  Later, the hospital decides to store the doctor assigned to each patient.
-- Task:
--  Write a SQL command to add a new column DoctorAssigned VARCHAR(50) to the Patients table.
alter table patients add DoctorAssigned VARCHAR(50);

-- 3) PRIMARY KEY & FOREIGN KEY
-- Scenario:
--  You are creating a database for an online bookstore.
-- Task:
--  Define a primary key for Books(BookID) and a foreign key in Orders(BookID) referencing Books.
Create database if not exists online_bookstore;

create table if not exists Books(
Bookid int primary key auto_increment,
Authorname varchar(30),
price decimal (10,2)
);

create table if not exists Orders(
orderid int primary key auto_increment,
orderdate  Date,
Customer_name varchar(30),
Bookid int,
foreign key(Bookid) references  Books(Bookid)
);

-- 4)UNIQUE Constraint
-- Scenario:
--  Each book must have a unique ISBN.
-- Task:
--  Add a UNIQUE constraint to the ISBN column in Books.
-- Expected Output:
--  ISBN values are enforced as unique.

create table if not exists Books(
Bookid int primary key auto_increment,
Authorname varchar(30),
price decimal (10,2),
ISBN varchar(20) unique
);


-- 5)DELETE vs TRUNCATE
-- Scenario:
--  The store wants to clear test orders but sometimes preserve structure.
-- Task:
--  Demonstrate DELETE with WHERE clause and TRUNCATE for Orders table.

Delete from orders where  order_id=101;
select * FROM orders;
truncate table orders;

-- 6)Scenario:
--  In a university database, you want to list unique departments.
-- Task:
--  Write a SQL query to return distinct department names.

create database if not exists university;
use university;
create table departments (dept_id int primary key auto_increment,
dept_name varchar(20)
);
select distinct dept_name from departments;

-- 7)Some students don’t have email addresses recorded.
-- Task:
--  Write queries to find students with NULL and NOT NULL emails.
-- Expected Output:
--  The queries return correct subsets of students.

select student_id,  student_name from students where email is null;
select student_id,  student_name from students where email is not null;

-- 8)Scenario:
--  Filter students enrolled in specific courses or within certain GPA ranges.
-- Task:
--  Write queries using IN, BETWEEN, and NOT BETWEEN operators.
-- Expected Output:
--  Correct sets of students are returned.

select student_id,  student_name from students where courses in ('Computer science','Commerce','Accounts');
select student_id,  student_name from students where gpa between 7.0 AND 9.0;
select student_id,  student_name from students where gpa not between 7.0 AND 9.0;

-- 9) In an e-commerce system, show the top 3 highest-priced products.
-- Task:
--  Write a SQL query using ORDER BY and LIMIT.
-- Expected Output:
--  Top 3 products by price are displayed.

select product_id, product_name, Quantity, price from products order  by price desc limit 3;

-- 10)Management wants statistics of sales data.
-- Task:
--  Write queries using COUNT, SUM, AVG, MAX, MIN on Sales table.
-- Expected Output:
--  Aggregated results are returned.

select count(*) as salescount from sales;
select sum(price) as totalprice from sales;
select avg(price) as average from sales;
select max(price) as maxprice from sales;
select min(price) as minprice from sales;

-- 11)Find departments with more than 10 employees.
-- Task:
--  Write a query using GROUP BY and HAVING.
-- Expected Output:
--  Only departments with >10 employees are returned.

select dept_name, count(*) as employeecount  from employees group by dept_name having count(*) >10;

-- 12)Scenario:
--  Show students with their enrolled course names.
-- Task:
--  Write a query joining Students and Courses.
-- Expected Output:
--  Results include only students with valid enrollments.
select s.studentname,c.coursename from students s inner join courses on s.course_id = c.course_id;

-- 13)LEFT & RIGHT JOIN
-- Scenario:
--  List all students and their courses, including those without matches.
-- Task:
--  Use LEFT JOIN and RIGHT JOIN between Students and Enrollments.
-- Expected Output:
--  All students/courses are shown with NULLs where no match exists.

select s.studentname,s.student_id ,e.course_name
from students s 
left join 
Enrollments e on s.student_id = e.student_id ;

-- 14)Scenario:
--  Combine lists of current and past employees.
-- Task:
--  Write queries demonstrating UNION and UNION ALL.
-- Expected Output:
--  UNION removes duplicates, UNION ALL keeps all rows. 
select emp_id, emp_name from current_employees
union 
select emp_id, emp_name from past_employees;

-- 15)Scenario:
--  Clean up employee names for reporting.
-- Task:
--  Write queries using UPPER, LOWER, SUBSTRING, CONCAT.
-- Expected Output:
--  Formatted name outputs are displayed.

select upper(emp_first_name) as formetted_empfirstname from employee;
select Lower(emp_last_name) as formetted_emplastname from employee;
select substring(emp_last_name,1,3) as substring_name from employee;
select concat(emp_last_name,'',emp_first_name) as fullname from employee;



-- 16)Scenario:
--  Calculate employee tenure in years.
-- Task:
--  Use DATE functions like YEAR(), DATEDIFF(), NOW().
-- Expected Output:
--  Employee tenure is calculated correctly.
select emp_name , emp_id , datediff(now(),hire_date/365,2) as tenure_years from employees;
select emp_name , emp_id ,year(now())-year(hire_date) as tenure_years from employees;

-- 17)Scenario:
--  Create a reusable function to return full name of a student.
-- Task:
--  Write and test a UDF combining FirstName + LastName.
-- Expected Output:
--  Full name is returned when function is called.

DELIMITER //

CREATE FUNCTION GetFullName (FirstName VARCHAR(50), LastName VARCHAR(50))
RETURNS VARCHAR(101)
DETERMINISTIC
BEGIN
    RETURN CONCAT(FirstName, ' ', LastName);
END ;

DELIMITER ;

-- 18)Scenario:
--  HR wants a quick way to fetch employee details by ID.
-- Task:
--  Create a stored procedure accepting EmployeeID as input.
-- Expected Output:
--  Employee details are returned when procedure is executed.

delimiter //
create procedure employee_id(In e_id  Int)
begin
	select emp_name from Employee where emp_id=e_id;
end //
delimiter ;

call employee_id(2);

-- 19)Scenario:
--  Management wants a view for employee name and department.
-- Task:
--  Write a CREATE VIEW statement.
-- Expected Output:

CREATE VIEW EmployeeDepartmentView AS
SELECT 
    EmployeeName,
    Department
FROM 
    Employees;
    
    
-- 20)Create a view joining Employees, Departments, and Salaries.
-- Task:
--  Write SQL to define a complex view with multiple joins.
-- Expected Output:
--  The view returns combined data from all three tables.
create view  emp_details as
select e.emp_id,e.emp_name,d.dept_name,s.salary 
from employees e
left join employees e on e.emp_id = d.dept_id
left join departments d on d.dept_id = s.dept_id;

SELECT * FROM emp_details

-- 21)Scenario:
--  Log every deletion in the Orders table.
-- Task:
--  Write a trigger to insert deleted rows into Order_History.
-- Expected Output:
--  Deleted records are logged automatically.

DELIMITER //

CREATE TRIGGER LogOrderDeletion
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_History (OrderID, CustomerName, OrderDate, Amount, DeletedAt)
    VALUES (OLD.OrderID, OLD.CustomerName, OLD.OrderDate, OLD.Amount, NOW());
END //

DELIMITER ;

-- 22)Scenario:
--  Grant reporting access to junior analysts.
-- Task:
--  Write SQL using GRANT and REVOKE commands.
-- Expected Output:
--  User privileges are updated accordingly.


GRANT SELECT   ON sales TO 'junior_analyst'@'localhost';

REVOKE SELECT ON sales From 'junior_analyst'@'localhost';


-- 23)Scenario:
--  During a bank transfer, ensure atomicity.
-- Task:
--  Write SQL using COMMIT, ROLLBACK, SAVEPOINT.
-- Expected Output:
--  Transaction integrity is maintained.
START TRANSACTION;

INSERT INTO bank_transfer (AccountNo, Amount, PaymentDate)
VALUES (12345678, 4500, '2025-10-29');

SAVEPOINT step1;  -- Save progress

INSERT INTO bank_transfer (AccountNo, Amount, PaymentDate)
VALUES (323456789, 5200, '2025-10-29');
select * from bank_transfer;
-- Suppose you realize the second one is wrong
ROLLBACK TO step1;  -- Undo last insert only
-- Now finalize the first payment
COMMIT;



