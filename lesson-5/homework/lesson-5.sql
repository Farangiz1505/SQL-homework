--Easy-Level Tasks (10)
--1. Write a query that uses an alias to rename the ProductName column as Name in the Products table.
SELECT ProductName AS Name 
FROM Products;
--2. Write a query that uses an alias to rename the Customers table as Client for easier reference.
SELECT * 
FROM Customers AS Client;
--3. Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discontinued.
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discontinued;
--4. Write a query to find the intersection of Products and Products_Discontinued tables using INTERSECT.
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discontinued;

--5. Use UNION ALL to combine two tables, Products and Orders, that have the same structure.
SELECT * FROM Products
UNION ALL
SELECT * FROM Orders;
--6. Write a query to select distinct customer names (CustomerName) and their corresponding Country using SELECT DISTINCT.
SELECT DISTINCT CustomerName, Country 
FROM Customers;
--7. Write a query that uses CASE to create a conditional column that displays 'High' if Price > 100, and 'Low' if Price <= 100.
SELECT ProductName, Price,
       CASE 
           WHEN Price > 100 THEN 'High'
           ELSE 'Low'
       END AS PriceCategory
FROM Products;
--8. Write a query to filter Employees by Department and group them by Country.
SELECT Country, COUNT(EmployeeID) AS EmployeeCount 
FROM Employees 
WHERE Department = 'Sales' 
GROUP BY Country;
--9. Use GROUP BY to find the number of products (ProductID) in each Category.
SELECT Category, COUNT(ProductID) AS ProductCount 
FROM Products 
GROUP BY Category;
--10. Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise.
SELECT ProductName, Stock, 
       IIF(Stock > 100, 'Yes', 'No') AS InStock
FROM Products;
 --Medium-Level Tasks (10)

--11. Write a query that joins the Orders and Customers tables using INNER JOIN and aliases the CustomerName as ClientName.
SELECT o.OrderID, c.CustomerName AS ClientName, o.OrderDate
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;
--12. Use UNION to combine results from two queries that select ProductName from Products and ProductName from OutOfStock tables.
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM OutOfStock;
--13. Write a query that returns the difference between the Products and DiscontinuedProducts tables using EXCEPT.
SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM DiscontinuedProducts;
--14. Write a query that uses CASE to assign a value of 'Eligible' to customers who have placed more than 5 orders, otherwise 'Not Eligible'.
SELECT CustomerID,
       CASE 
           WHEN COUNT(OrderID) > 5 THEN 'Eligible'
           ELSE 'Not Eligible'
       END AS Status
FROM Orders
GROUP BY CustomerID;
--15. Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 100, and 'Affordable' if less.
SELECT ProductName, Price, 
       IIF(Price > 100, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;
--16. Write a query that uses GROUP BY to count the number of orders per CustomerID in the Orders table.
SELECT CustomerID, COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY CustomerID;

--17. Write a query to find employees in the Employees table who have either Age < 25 or Salary > 6000.
SELECT * FROM Employees
WHERE Age < 25 OR Salary > 6000;
--18. Use GROUP BY to find the total sales (SalesAmount) per Region in the Sales table.
SELECT Region, SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY Region;
--19. Write a query that combines data from the Customers and Orders tables using LEFT JOIN, and create an alias for OrderDate.
SELECT c.CustomerName, o.OrderID, o.OrderDate AS DateOrdered
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;
--20. Use IF statement to update the salary of an employee based on their department, increase by 10% if they work in 'HR'.
UPDATE Employees
SET Salary = Salary * 1.1
WHERE Department = 'HR';
