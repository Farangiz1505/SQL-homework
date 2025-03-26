Easy-Level Tasks
--1. Write a query to perform an INNER JOIN between Orders and Customers using AND in the ON clause to filter orders placed after 2022.
Select Orders.*, Customers.*
FROM Orders
INNER JOIN Customers 
ON Orders.CustomerID = Customers.CustomerID 
AND Orders.OrderDate > '2022-12-31';
--2. Write a query to join Employees and Departments using OR in the ON clause to show employees in either the 'Sales' or 'Marketing' department.
SELECT Employees.*, Departments.*
FROM Employees
INNER JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID 
OR Departments.DepartmentName IN ('Sales', 'Marketing');
--3. Write a query to join a derived table (for example, SELECT * FROM Products WHERE Price > 100) with the Orders table to display products and their corresponding orders.
SELECT P.*, O.*
FROM (SELECT * FROM Products WHERE Price > 100) AS P
INNER JOIN Orders O 
ON P.ProductID = O.ProductID;
--4. Write a query to join a Temp table (for example, Temp_Orders) and the Orders table to show orders that are present in both tables.

SELECT O.*
FROM Orders O
INNER JOIN Temp_Orders T
ON O.OrderID = T.OrderID;
--5. Write a query to demonstrate a CROSS APPLY between Employees and a derived table that shows their department's top-performing sales (e.g., top 5 sales).
SELECT E.*, S.*
FROM Employees E
CROSS APPLY (
    SELECT TOP 5 * 
    FROM Sales S 
    WHERE S.DepartmentID = E.DepartmentID 
    ORDER BY S.TotalSales DESC
) AS S;
--6. Write a query to join Customers and Orders using AND in the ON clause to filter customers who have placed orders in 2023 and have a loyalty status of 'Gold'.

SELECT Customers.*, Orders.*
FROM Customers
INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID 
AND Orders.OrderDate BETWEEN '2023-01-01' AND '2023-12-31' 
AND Customers.LoyaltyStatus = 'Gold';
--7. Write a query to join a derived table (SELECT CustomerID, COUNT(*) FROM Orders GROUP BY CustomerID) with the Customers table to show the number of orders per customer.

SELECT C.*, O.OrderCount
FROM Customers C
INNER JOIN (
    SELECT CustomerID, COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY CustomerID
) O 
ON C.CustomerID = O.CustomerID;
--8. Write a query to join Products and Suppliers using OR in the ON clause to show products supplied by either 'Supplier A' or 'Supplier B'.

SELECT Products.*, Suppliers.*
FROM Products
INNER JOIN Suppliers 
ON Products.SupplierID = Suppliers.SupplierID 
OR Suppliers.SupplierName IN ('Supplier A', 'Supplier B');
--9. Write a query to demonstrate the use of OUTER APPLY between Employees and a derived table that returns each employee's most recent order.

SELECT E.*, O.*
FROM Employees E
OUTER APPLY (
    SELECT TOP 1 * 
    FROM Orders O 
    WHERE O.EmployeeID = E.EmployeeID 
    ORDER BY O.OrderDate DESC
) AS O;
--10. Write a query to perform a CROSS APPLY between Departments and a table-valued function that returns a list of employees working in that department.

SELECT D.*, E.*
FROM Departments D
CROSS APPLY dbo.GetEmployeesByDepartment(D.DepartmentID) AS E;
Medium-Level Tasks
--1. Write a query that uses the AND logical operator in the ON clause to join Orders and Customers, and filter customers who placed an order with a total amount greater than 5000.

SELECT Customers.*, Orders.*
FROM Customers
INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID 
AND Orders.TotalAmount > 5000;
--2. Write a query that uses the OR logical operator in the ON clause to join Products and Sales to filter products that were either sold in 2022 or have a discount greater than 20%.

SELECT Products.*, Sales.*
FROM Products
INNER JOIN Sales 
ON Products.ProductID = Sales.ProductID 
OR Sales.SaleDate BETWEEN '2022-01-01' AND '2022-12-31' 
OR Sales.Discount > 20;
--3. Write a query to join a derived table that calculates the total sales (SELECT ProductID, SUM(Amount) FROM Sales GROUP BY ProductID) with the Products table to show total sales for each product.

SELECT P.*, S.TotalSales
FROM Products P
INNER JOIN (
    SELECT ProductID, SUM(Amount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
) S 
ON P.ProductID = S.ProductID;
--4. Write a query to join a Temp table (Temp_Products) and the Products table to show the products that have been discontinued in the Temp table.

SELECT P.*
FROM Products P
INNER JOIN Temp_Products T
ON P.ProductID = T.ProductID
WHERE T.IsDiscontinued = 1;
--5. Write a query to demonstrate CROSS APPLY by applying a table-valued function to each row of the Employees table to return the sales performance for each employee.

SELECT E.*, SP.*
FROM Employees E
CROSS APPLY dbo.GetSalesPerformance(E.EmployeeID) AS SP;
--6. Write a query to join Employees and Departments using AND in the ON clause to filter employees who belong to the 'HR' department and whose salary is greater than 5000.

SELECT Employees.*, Departments.*
FROM Employees
INNER JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID 
AND Departments.DepartmentName = 'HR' 
AND Employees.Salary > 5000;
--7. Write a query to join Orders and Payments using OR in the ON clause to show orders that have either been paid fully or partially.

SELECT Orders.*, Payments.*
FROM Orders
INNER JOIN Payments 
ON Orders.OrderID = Payments.OrderID 
OR Payments.Status IN ('Paid', 'Partially Paid');
--8. Write a query to use OUTER APPLY to return all customers along with their most recent orders, including customers who have not placed any orders.

SELECT C.*, O.*
FROM Customers C
OUTER APPLY (
    SELECT TOP 1 * 
    FROM Orders O 
    WHERE O.CustomerID = C.CustomerID 
    ORDER BY O.OrderDate DESC
) AS O;
--9. Write a query to join Products and Sales using AND in the ON clause to filter products that were sold in 2023 and have a rating greater than 4.

SELECT Products.*, Sales.*
FROM Products
INNER JOIN Sales 
ON Products.ProductID = Sales.ProductID 
AND Sales.SaleDate BETWEEN '2023-01-01' AND '2023-12-31' 
AND Products.Rating > 4;
--10. Write a query to join Employees and Departments using OR in the ON clause to show employees who either belong to the 'Sales' department or have a job title that contains 'Manager'.

SELECT Employees.*, Departments.*
FROM Employees
INNER JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID 
OR Departments.DepartmentName = 'Sales' 
OR Employees.JobTitle LIKE '%Manager%';
 Hard-Level Tasks
--1. Write a query to demonstrate the use of the AND logical operator in the ON clause between Orders and Customers, and filter orders made by customers who are located in 'New York' and have made more than 10 orders.

SELECT C.*, O.*
FROM Customers C
INNER JOIN Orders O 
ON C.CustomerID = O.CustomerID 
AND C.City = 'New York'
AND (SELECT COUNT(*) FROM Orders WHERE Orders.CustomerID = C.CustomerID) > 10;
--2. Write a query to demonstrate the use of OR in the ON clause when joining Products and Sales to show products that are either part of the 'Electronics' category or have a discount greater than 15%.

SELECT Products.*, Sales.*
FROM Products
INNER JOIN Sales 
ON Products.ProductID = Sales.ProductID 
OR Products.Category = 'Electronics' 
OR Sales.Discount > 15;
--3. Write a query to join a derived table that returns a count of products per category (SELECT CategoryID, COUNT(*) FROM Products GROUP BY CategoryID) with the Categories table to show the count of products in each category.

SELECT C.*, P.ProductCount
FROM Categories C
INNER JOIN (
    SELECT CategoryID, COUNT(*) AS ProductCount
    FROM Products
    GROUP BY CategoryID
) P 
ON C.CategoryID = P.CategoryID;
--4. Write a query to join a Temp table (Temp_Employees) with the Employees table using a complex condition in the ON clause (e.g., salary > 4000 AND department = 'IT').

SELECT E.*
FROM Employees E
INNER JOIN Temp_Employees T
ON E.EmployeeID = T.EmployeeID
AND E.Salary > 4000
AND E.Department = 'IT';
--5. Write a query to demonstrate CROSS APPLY by applying a table-valued function that returns the number of employees working in each department for every row in the Departments table.

SELECT D.*, E.*
FROM Departments D
CROSS APPLY dbo.GetEmployeeCountByDepartment(D.DepartmentID) AS E;
--6. Write a query to join Orders and Customers using AND in the ON clause to show orders where the customer is from 'California' and the order amount is greater than 1000.

SELECT C.*, O.*
FROM Customers C
INNER JOIN Orders O 
ON C.CustomerID = O.CustomerID 
AND C.State = 'California' 
AND O.TotalAmount > 1000;
--7. Write a query to join Employees and Departments using a complex OR condition in the ON clause to show employees who are in the 'HR' or 'Finance' department, or have an 'Executive' job title.

SELECT Employees.*, Departments.*
FROM Employees
INNER JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID 
OR Departments.DepartmentName IN ('HR', 'Finance') 
OR Employees.JobTitle LIKE '%Executive%';
--8. Write a query to use OUTER APPLY between Customers and a table-valued function that returns all orders placed by each customer, and show customers who have not placed any orders.

SELECT C.*, O.*
FROM Customers C
OUTER APPLY dbo.GetCustomerOrders(C.CustomerID) AS O;
--9. Write a query to join Sales and Products using AND in the ON clause to filter products that have both a sales quantity greater than 100 and a price above 50.

SELECT P.*, S.*
FROM Products P
INNER JOIN Sales S 
ON P.ProductID = S.ProductID 
AND S.Quantity > 100 
AND P.Price > 50;
--10. Write a query to join Employees and Departments using OR in the ON clause to show employees in either the 'Sales' or 'Marketing' department, and with a salary greater than 6000.

SELECT Employees.*, Departments.*
FROM Employees
INNER JOIN Departments 
ON Employees.DepartmentID = Departments.DepartmentID 
OR Departments.DepartmentName IN ('Sales', 'Marketing') 
AND Employees.Salary > 6000;
