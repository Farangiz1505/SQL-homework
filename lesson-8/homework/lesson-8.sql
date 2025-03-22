EASY-LEVEL TASKS
--1. Write a query to join the Customers and Orders tables using an INNER JOIN to get the CustomerName and their OrderDate. 
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Country VARCHAR(50)
);
2. INSERT INTO Customers (CustomerID, CustomerName, Country) VALUES
(1, 'John Doe', 'USA'),
(2, 'Jane Smith', 'UK'),
(3, 'Michael Johnson', 'Canada'),
(4, 'Sarah Brown', 'Australia'),
(5, 'David Green', 'USA'),
(6, 'Linda White', 'Canada'),
(7, 'James Black', 'UK'),
(8, 'Emily Blue', 'Australia'),
(9, 'Matthew Red', 'USA'),
(10, 'Olivia Yellow', 'Canada'),
(11, 'John Doe', 'Australia'),
(12, 'Jane Smith', 'Canada'),
(13, 'Michael Johnson', 'UK'),
(14, 'Sarah Brown', 'USA'),
(15, 'David Green', 'Canada'),
(16, 'Linda White', 'Australia'),
(17, 'James Black', 'USA'),
(18, 'Emily Blue', 'Canada'),
(19, 'Matthew Red', 'UK'),
(20, 'Olivia Yellow', 'Australia'),
(21, 'John Doe', 'Canada'),
(22, 'Jane Smith', 'Australia'),
(23, 'Michael Johnson', 'USA'),
(24, 'Sarah Brown', 'UK'),
(25, 'David Green', 'Australia'),
(26, 'Linda White', 'USA'),
(27, 'James Black', 'Canada'),
(28, 'Emily Blue', 'UK'),
(29, 'Matthew Red', 'Australia'),
(30, 'Olivia Yellow', 'USA'),
(31, 'John Doe', 'UK'),
(32, 'Jane Smith', 'USA'),
(33, 'Michael Johnson', 'Australia'),
(34, 'Sarah Brown', 'Canada'),
(35, 'David Green', 'UK'),
(36, 'Linda White', 'USA'),
(37, 'James Black', 'Australia'),
(38, 'Emily Blue', 'Canada'),
(39, 'Matthew Red', 'USA'),
(40, 'Olivia Yellow', 'UK');
--Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);
--Insert 40 Rows into Products Table
INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1200.00),
(2, 'Smartphone', 800.00),
(3, 'Tablet', 400.00),
(4, 'Monitor', 200.00),
(5, 'Keyboard', 50.00),
(6, 'Mouse', 30.00),
(7, 'Printer', 150.00),
(8, 'Headphones', 100.00),
(9, 'Speakers', 80.00),
(10, 'Webcam', 60.00),
(11, 'Laptop', 1100.00),
(12, 'Smartphone', 750.00),
(13, 'Tablet', 420.00),
(14, 'Monitor', 220.00),
(15, 'Keyboard', 55.00),
(16, 'Mouse', 35.00),
(17, 'Printer', 160.00),
(18, 'Headphones', 120.00),
(19, 'Speakers', 90.00),
(20, 'Webcam', 65.00),
(21, 'Laptop', 1300.00),
(22, 'Smartphone', 850.00),
(23, 'Tablet', 380.00),
(24, 'Monitor', 210.00),
(25, 'Keyboard', 60.00),
(26, 'Mouse', 40.00),
(27, 'Printer', 170.00),
(28, 'Headphones', 130.00),
(29, 'Speakers', 95.00),
(30, 'Webcam', 70.00),
(31, 'Laptop', 1400.00),
(32, 'Smartphone', 900.00),
(33, 'Tablet', 430.00),
(34, 'Monitor', 230.00),
(35, 'Keyboard', 65.00),
(36, 'Mouse', 45.00),
(37, 'Printer', 180.00),
(38, 'Headphones', 140.00),
(39, 'Speakers', 100.00),
(40, 'Webcam', 75.00);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
--Insert 40 Rows into Orders Table
INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate, Quantity) VALUES
(1, 1, 2, '2023-01-15', 2),
(2, 2, 3, '2023-01-20', 1),
(3, 3, 5, '2023-02-15', 3),
(4, 4, 8, '2023-02-18', 1),
(5, 5, 6, '2023-03-10', 4),
(6, 6, 7, '2023-03-12', 2),
(7, 7, 9, '2023-03-20', 1),
(8, 8, 1, '2023-04-05', 1),
(9, 9, 4, '2023-04-10', 2),
(10, 10, 10, '2023-04-15', 1),
(11, 11, 3, '2023-05-01', 2),
(12, 12, 6, '2023-05-03', 1),
(13, 13, 2, '2023-05-10', 1),
(14, 14, 8, '2023-06-01', 3),
(15, 15, 5, '2023-06-02', 2),
(16, 16, 7, '2023-06-15', 2),
(17, 17, 9, '2023-06-20', 1),
(18, 18, 4, '2023-07-01', 3),
(19, 19, 1, '2023-07-05', 1),
(20, 20, 10, '2023-07-10', 1),
(21, 21, 6, '2023-08-01', 2),
(22, 22, 2, '2023-08-03', 3),
(23, 23, 3, '2023-08-10', 1),
(24, 24, 5, '2023-09-01', 1),
(25, 25, 7, '2023-09-05', 2),
(26, 26, 8, '2023-09-10', 3),
(27, 27, 4, '2023-09-15', 1),
(28, 28, 9, '2023-10-01', 1),
(29, 29, 1, '2023-10-05', 2),
(30, 30, 3, '2023-10-10', 1),
(31, 31, 6, '2023-11-01', 4),
(32, 32, 7, '2023-11-05', 3),
(33, 33, 5, '2023-11-10', 2),
(34, 34, 9, '2023-11-15', 1),
(35, 35, 8, '2023-12-01', 1),
(36, 36, 10, '2023-12-05', 2),
(37, 37, 4, '2023-12-10', 3),
(38, 38, 3, '2023-12-15', 2),
(39, 39, 2, '2023-12-20', 3),
(40, 40, 1, '2023-12-25', 1);
________________________________________

SELECT Customers.CustomerName,Orders.OrderDate
from Customers
inner join Orders On Customers.CustomerID=Orders.CustomerID;

--2. Write a query to demonstrate a One to One relationship between the EmployeeDetails and Employees tables by joining them.
CREATE TABLE EmployeeDetails (
    EmployeeID INT PRIMARY KEY,
    [address] VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    DateOfBirth DATE
);
INSERT INTO EmployeeDetails (EmployeeID, Address, Phone, Email, DateOfBirth)  
VALUES  
(1, 'Tashkent, Chilonzor', '+998901234567', 'ali.karimov@example.com', '1992-04-10'),  
(2, 'Samarkand, Registon', '+998937654321', 'bekzod.tursunov@example.com', '1990-07-22'),  
(3, 'Andijan, Bobur street', '+998905678912', 'shahnoza.ismoilova@example.com', '1988-12-15'),  
(4, 'Fergana, Qoqon', '+998935678900', 'kamila.nurmatova@example.com', '1995-03-25'),  
(5, 'Bukhara, Ark', '+998977890123', 'javlon.xudoyberdiyev@example.com', '1985-05-18'),  
(6, 'Navoi, Zargarlik street', '+998907891234', 'olim.ibragimov@example.com', '1993-09-30'),  
(7, 'Jizzakh, Dustlik street', '+998937654987', 'ziyoda.mamadalieva@example.com', '1994-06-11'),  
(8, 'Nukus, Qoraqalpogiston', '+998936789010', 'rustam.xolmurodov@example.com', '1996-11-05'),  
(9, 'Guliston, Sarbon street', '+998907654789', 'dilmurod.bozorov@example.com', '1987-01-08'),  
(10, 'Termiz, Sherobod', '+998977890654', 'gulnora.saidova@example.com', '1999-08-12');
CREATE TABLE Employees(
EmplyeeID int primary key,
FirstName Varchar(50),
LastName Varchar(50),
Position varchar(50),
DepartmentId int
);
INSERT INTO Employees (EmplyeeID, FirstName, LastName, Position, DepartmentID)  
VALUES  
(1, 'Ali', 'Karimov', 'Software Engineer', 101),  
(2, 'Bekzod', 'Tursunov', 'Data Analyst', 102),  
(3, 'Shahnoza', 'Ismoilova', 'HR Manager', 103),  
(4, 'Kamila', 'Nurmatova', 'Marketing Specialist', 104),  
(5, 'Javlon', 'Xudoyberdiyev', 'Project Manager', 105),  
(6, 'Olim', 'Ibragimov', 'DevOps Engineer', 101),  
(7, 'Ziyoda', 'Mamadalieva', 'Business Analyst', 102),  
(8, 'Rustam', 'Xolmurodov', 'QA Engineer', 106),  
(9, 'Dilmurod', 'Bozorov', 'Network Administrator', 107),  
(10, 'Gulnora', 'Saidova', 'UI/UX Designer', 108);
select Employees.EmplyeeID,FirstName,LastName,Position,DepartmentId,EmployeeDetails.Phone
from Employees
Inner join EmployeeDetails On Employees.EmplyeeID=EmployeeDetails.EmployeeID
--3. Write a query to join the Products and Categories tables to show ProductName along with CategoryName using INNER JOIN. 
--Create Products Table
CREATE TABLE Products8 (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);
--Insert 40 Rows into Products8 Table
INSERT INTO Products8 (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1200.00),
(2, 'Smartphone', 800.00),
(3, 'Tablet', 400.00),
(4, 'Monitor', 200.00),
(5, 'Keyboard', 50.00),
(6, 'Mouse', 30.00),
(7, 'Printer', 150.00),
(8, 'Headphones', 100.00),
(9, 'Speakers', 80.00),
(10, 'Webcam', 60.00),
(11, 'Laptop', 1100.00),
(12, 'Smartphone', 750.00),
(13, 'Tablet', 420.00),
(14, 'Monitor', 220.00),
(15, 'Keyboard', 55.00),
(16, 'Mouse', 35.00),
(17, 'Printer', 160.00),
(18, 'Headphones', 120.00),
(19, 'Speakers', 90.00),
(20, 'Webcam', 65.00),
(21, 'Laptop', 1300.00),
(22, 'Smartphone', 850.00),
(23, 'Tablet', 380.00),
(24, 'Monitor', 210.00),
(25, 'Keyboard', 60.00),
(26, 'Mouse', 40.00),
(27, 'Printer', 170.00),
(28, 'Headphones', 130.00),
(29, 'Speakers', 95.00),
(30, 'Webcam', 70.00),
(31, 'Laptop', 1400.00),
(32, 'Smartphone', 900.00),
(33, 'Tablet', 430.00),
(34, 'Monitor', 230.00),
(35, 'Keyboard', 65.00),
(36, 'Mouse', 45.00),
(37, 'Printer', 180.00),
(38, 'Headphones', 140.00),
(39, 'Speakers', 100.00),
(40, 'Webcam', 75.00);
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);
INSERT INTO Categories (CategoryID, CategoryName)  
VALUES  
(1, 'Electronics'),  
(2, 'Furniture'),  
(3, 'Clothing'),  
(4, 'Books'),  
(5, 'Home Appliances'),  
(6, 'Sports & Outdoors'),  
(7, 'Toys & Games'),  
(8, 'Beauty & Personal Care'),  
(9, 'Automotive'),  
(10, 'Grocery');
Select Products8.ProductName,CATEGORIES.CATEGORYNAME
From Products8
inner join CATEGORIES ON Products8.ProductID=CATEGORIES.CATEGORYID

--4. Write a query to show all Customers and the corresponding OrderDate using LEFT JOIN between Customers and Orders.
select Customers.CustomerName,Orders.OrderDate
from Customers
left join Orders on Customers.CustomerID=Orders.CustomerID
--5. Write a query that demonstrates a Many to Many relationship between Orders and Products tables using an intermediate OrderDetails table. 
create table OrderDetails(
orderId int primary key,
quantity Varchar(100)
);
select orders.OrderID,Products8.ProductName,OrderDetails.quantity
from Orders
inner join OrderDetails on Orders.OrderID=OrderDetails.orderId
inner join Products8 on OrderDetails.orderId=Products8.ProductID
--6. Write a query to perform a CROSS JOIN between Products and Categories, showing all possible combinations of products and categories.
select Products8.ProductName,CATEGORIES.CATEGORYNAME
from Products8
cross join CATEGORIES 
--7. Write a query to demonstrate the One to Many relationship between Customers and Orders using INNER JOIN.
Select Customers.CustomerName,Orders.OrderDate,Orders.OrderID
from Customers
inner join Orders on Customers.CustomerID=Orders.CustomerID
--8. Write a query to filter a CROSS JOIN result using the WHERE clause, showing only combinations of Products and Orders where OrderAmount > 500.
SELECT Products.ProductName, Orders.OrderID, Orders.OrderAmount  
FROM Products  
CROSS JOIN Orders  
WHERE Orders.OrderAmount > 500;
--9. Write a query that uses INNER JOIN to join the Employees and Departments tables, showing employee names and their corresponding department names. 
SELECT Employees.EmployeeName, Departments.DepartmentName  
FROM Employees  
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentId
--10. Write a query that uses the ON clause with a <> operator to join two tables and return rows where the values in the two columns are not equal.
SELECT A.ID AS FirstID, B.ID AS SecondID  
FROM TableA A  
INNER JOIN TableB B ON A.ColumnName <> B.ColumnName;
Medium-Level Tasks (10)
--11. Write a query to demonstrate a One to Many relationship by joining the Customers and Orders tables using INNER JOIN, showing the CustomerName and the total number of orders. 
SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName;

--12. Write a query to demonstrate a Many to Many relationship between Students and Courses by joining through the StudentCourses table. 
SELECT Students.StudentName, Courses.CourseName
FROM Students
INNER JOIN StudentCourses ON Students.StudentID = StudentCourses.StudentID
INNER JOIN Courses ON StudentCourses.CourseID = Courses.CourseID;

--13. Write a query to use a CROSS JOIN between Employees and Departments tables, and filter the results by Salary > 5000 using the WHERE clause.
SELECT Employees.EmployeeName, Departments.DepartmentName, Employees.Salary
FROM Employees
CROSS JOIN Departments
WHERE Employees.Salary > 5000;

--14. Write a query to demonstrate a One to One relationship by joining the Employee and EmployeeDetails tables, showing each employee’s name and their details. 
SELECT Employees.EmployeeName, EmployeeDetails.phone, EmployeeDetails.email, EmployeeDetails.DateOfBirth
FROM Employees
INNER JOIN EmployeeDetails ON Employees.EmployeeID = EmployeeDetails.EmployeeID;

--15. Write a query to perform an INNER JOIN between Products and Suppliers and use the WHERE clause to filter only products supplied by 'Supplier A'. 
SELECT Products.ProductName, Suppliers.SupplierName
FROM Products
INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Suppliers.SupplierName = 'Supplier A';

--16. Write a query to perform a LEFT JOIN between Products and Sales, and display all products along with their sales quantity (including products with no sales).
SELECT Products.ProductName, COALESCE(Sales.Quantity, 0) AS SalesQuantity
FROM Products
LEFT JOIN Sales ON Products.ProductID = Sales.ProductID;

--17. Write a query to join Employees and Departments using a WHERE clause, and show all employees whose salary is greater than 4000 and who work in the ‘HR’ department.
SELECT Employees.EmployeeName, Departments.DepartmentName, Employees.Salary
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE Employees.Salary > 4000 AND Departments.DepartmentName = 'HR';

--18. Write a query to show how to use the >= operator in the ON clause to join two tables and return rows where the values meet the condition.
SELECT A.Table1Column, B.Table2Column
FROM Table1 A
INNER JOIN Table2 B ON A.SomeValue >= B.SomeValue;

--19. Write a query to demonstrate INNER JOIN and use the >= operator to find all products with a price greater than or equal to 50, and their respective suppliers.
SELECT Products.ProductName, Products.Price, Suppliers.SupplierName
FROM Products
INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Products.Price >= 50;

--20. Write a query to demonstrate a CROSS JOIN between Sales and Regions, and use the WHERE clause to show only regions with sales greater than 1000.
SELECT Sales.SaleID, Regions.RegionName, Sales.Amount
FROM Sales
CROSS JOIN Regions
WHERE Sales.Amount > 1000;
Hard-Level Tasks (10)
--21. Write a query that demonstrates a Many to Many relationship between Authors and Books using the intermediate AuthorBooks table, showing the AuthorName and the BookTitle.
SELECT Authors.AuthorName, Books.BookTitle
FROM Authors
INNER JOIN AuthorBooks ON Authors.AuthorID = AuthorBooks.AuthorID
INNER JOIN Books ON AuthorBooks.BookID = Books.BookID;

--22. Write a query to join Products and Categories using INNER JOIN, and filter the result to only include products where the CategoryName is not ‘Electronics’. 
SELECT Products.ProductName, Categories.CategoryName
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName <> 'Electronics';

--23. Write a query to perform a CROSS JOIN between Orders and Products, and filter the result with a WHERE clause to show only orders where the quantity is greater than 100.
SELECT Orders.OrderID, Products.ProductName, Orders.Quantity
FROM Orders
CROSS JOIN Products
WHERE Orders.Quantity > 100;

--24. Write a query that joins the Employees and Departments tables and uses a logical operator in the ON clause to only return employees who have been with the company for over 5 years. 
SELECT Employees.EmployeeName, Departments.DepartmentName, Employees.HireDate
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
AND DATEDIFF(YEAR, Employees.HireDate, GETDATE()) > 5;

--25. Write a query to show the difference between INNER JOIN and LEFT JOIN by returning employees and their departments, ensuring that employees without departments are included in the left join. 
-- INNER JOIN: Only employees who have departments
SELECT Employees.EmployeeName, Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

-- LEFT JOIN: Includes employees even if they don't have a department
SELECT Employees.EmployeeName, Departments.DepartmentName
FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

--26. Write a query that uses a CROSS JOIN between Products and Suppliers, and filters the result using WHERE to include only suppliers that supply products in 'Category A'.
SELECT Products.ProductName, Suppliers.SupplierName
FROM Products
CROSS JOIN Suppliers
WHERE Products.CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName = 'Category A');

--27. Write a query to demonstrate a One to Many relationship using INNER JOIN between Orders and Customers, and apply the >= operator to filter only customers with at least 10 orders.
SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
HAVING COUNT(Orders.OrderID) >= 10;

--28. Write a query to demonstrate the Many to Many relationship between Courses and Students, showing all courses and the number of students enrolled using the COUNT function.
SELECT Courses.CourseName, COUNT(StudentCourses.StudentID) AS TotalStudents
FROM Courses
LEFT JOIN StudentCourses ON Courses.CourseID = StudentCourses.CourseID
GROUP BY Courses.CourseName;

--29. Write a query to use a LEFT JOIN between Employees and Departments tables, and filter the result using the WHERE clause to show only employees in the 'Marketing' department. 
SELECT Employees.EmployeeName, Departments.DepartmentName
FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE Departments.DepartmentName = 'Marketing';

--30. Write a query that uses the ON clause with <= operator to join two tables and return rows where the values in the columns meet the condition.
SELECT A.Table1Column, B.Table2Column
FROM Table1 A
INNER JOIN Table2 B ON A.SomeValue <= B.SomeValue;
