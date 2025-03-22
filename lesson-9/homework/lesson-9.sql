Easy-Level Tasks (10)
--INNER JOIN between Employees and Departments, filtering salary > 5000
SELECT e.*, d.DepartmentName 
FROM Employees e 
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 5000;
--INNER JOIN between Customers and Orders, filtering orders from 2023
SELECT c.*, o.* 
FROM Customers c 
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023;
-- LEFT OUTER JOIN between Employees and Departments (show all employees)
SELECT e.*, d.DepartmentName 
FROM Employees e 
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;
--RIGHT OUTER JOIN between Products and Suppliers (show all suppliers)
SELECT p.*, s.SupplierName 
FROM Products p 
RIGHT JOIN Suppliers s ON p.SupplierID = s.SupplierID;
-- FULL OUTER JOIN between Orders and Payments (show all orders/payments)
SELECT o.*, p.PaymentID, p.Amount 
FROM Orders o 
FULL JOIN Payments p ON o.OrderID = p.OrderID;
--SELF JOIN on Employees (show EmployeeName and ManagerName)
SELECT e1.EmployeeName AS Employee, e2.EmployeeName AS Manager 
FROM Employees e1 
LEFT JOIN Employees e2 ON e1.ManagerID = e2.EmployeeID;
--JOIN between Products and Sales, filtering Sales > 100
SELECT p.*, s.SalesAmount 
FROM Products p 
INNER JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.SalesAmount > 100;
--INNER JOIN between Students and Courses, filtering enrolled in 'Math 101'
SELECT s.*, c.CourseName 
FROM Students s 
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101';
--INNER JOIN between Customers and Orders, filtering customers with >3 orders
SELECT c.*, COUNT(o.OrderID) AS OrderCount 
FROM Customers c 
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
HAVING COUNT(o.OrderID) > 3;
--LEFT OUTER JOIN between Employees and Departments, filtering HR department
SELECT e.*, d.DepartmentName 
FROM Employees e 
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR';
Medium-Level Tasks (10)
--INNER JOIN between Employees and Departments, filtering departments with >10 employees
SELECT e.*, d.DepartmentName 
FROM Employees e 
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentID IN (SELECT DepartmentID FROM Employees GROUP BY DepartmentID HAVING COUNT(*) > 10);
--LEFT OUTER JOIN between Products and Sales, filtering products with no sales
SELECT p.* 
FROM Products p 
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL;
--RIGHT OUTER JOIN between Customers and Orders, filtering customers with orders
SELECT c.* 
FROM Customers c 
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NOT NULL;
--FULL OUTER JOIN between Employees and Departments, filtering out NULL departments
SELECT e.*, d.DepartmentName 
FROM Employees e 
FULL JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IS NOT NULL;
--SELF JOIN on Employees to find employees with the same manager
SELECT e1.EmployeeName, e2.EmployeeName AS Colleague 
FROM Employees e1 
JOIN Employees e2 ON e1.ManagerID = e2.ManagerID 
WHERE e1.EmployeeID <> e2.EmployeeID;
 Hard-Level Tasks (10)
--JOIN between Employees and Departments, filtering employees with salary > department average
SELECT e.*, d.DepartmentName 
FROM Employees e 
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > (SELECT AVG(Salary) FROM Employees WHERE DepartmentID = e.DepartmentID);
--LEFT OUTER JOIN between Orders and Payments, filtering unpaid orders before 2020
SELECT o.* 
FROM Orders o 
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE o.OrderDate < '2020-01-01' AND p.PaymentID IS NULL;
--FULL OUTER JOIN between Products and Categories, filtering products with no category
SELECT p.*, c.CategoryName 
FROM Products p 
FULL JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.CategoryID IS NULL;
--SELF JOIN on Employees to find employees under the same manager earning > 5000
SELECT e1.EmployeeName, e2.EmployeeName AS Colleague 
FROM Employees e1 
JOIN Employees e2 ON e1.ManagerID = e2.ManagerID 
WHERE e1.EmployeeID <> e2.EmployeeID AND e1.Salary > 5000;
--RIGHT OUTER JOIN between Employees and Departments, filtering departments starting with ‘M’
SELECT e.*, d.DepartmentName 
FROM Employees e 
RIGHT JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName LIKE 'M%';
--JOIN between Products and Sales, filtering sales > 100
SELECT p.*, s.SalesAmount 
FROM Products p 
INNER JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.SalesAmount > 1000;
--LEFT OUTER JOIN between Students and Courses, filtering students not in 'Math 101'
SELECT s.* 
FROM Students s 
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName <> 'Math 101' OR c.CourseName IS NULL;
--FULL OUTER JOIN between Orders and Payments, filtering out orders without payment
SELECT o.*, p.PaymentID 
FROM Orders o 
FULL JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NOT NULL;
--INNER JOIN between Products and Categories, filtering products in 'Electronics' or 'Furniture'
SELECT p.* 
FROM Products p 
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');
