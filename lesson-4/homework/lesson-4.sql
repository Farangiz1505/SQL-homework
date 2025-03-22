Easy-Level Tasks (10)
 
  -- Write a query to select the top 5 employees from the Employees table.
SELECT TOP 5 * FROM Employees;
--Use SELECT DISTINCT to select unique ProductName values from the Products table.
SELECT DISTINCT ProductName FROM Products;
--Write a query that filters the Products table to show products with Price > 100.
SELECT * FROM Products WHERE Price > 100;
--Write a query to select all CustomerName values that start with 'A' using the LIKE operator.
SELECT CustomerName FROM Customers WHERE CustomerName LIKE 'A%';
--Order the results of a Products query by Price in ascending order.
SELECT * FROM Products ORDER BY Price ASC;
--Write a query that uses the WHERE clause to filter for employees with Salary >= 5000 and Department = 'HR'.
SELECT * FROM Employees WHERE Salary >= 5000 AND Department = 'HR';
--Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".
SELECT EmployeeID, ISNULL(Email, 'noemail@example.com') AS Email FROM Employees;
--Write a query that shows all products with Price BETWEEN 50 AND 100.
SELECT * FROM Products WHERE Price BETWEEN 50 AND 100;
--Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
SELECT DISTINCT Category, ProductName FROM Products;
---Order the results by ProductName in descending order.
SELECT * FROM Products ORDER BY ProductName DESC;
Medium-Level Tasks (10)
--Write a query to select the top 10 products from the Products table, ordered by Price DESC.
SELECT TOP 10 * FROM Products ORDER BY Price DESC;
--Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
SELECT EmployeeID, COALESCE(FirstName, LastName, 'Unknown') AS FullName FROM Employees;
--Write a query that selects distinct Category and Price from the Products table.
SELECT DISTINCT Category, Price FROM Products;
--Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
SELECT * FROM Employees WHERE (Age BETWEEN 30 AND 40) OR Department = 'Marketing';
--Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.
SELECT * FROM Employees ORDER BY Salary DESC OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
--Write a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order.
SELECT * FROM Products WHERE Price <= 1000 AND Stock > 50 ORDER BY Stock ASC;
--Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.
SELECT * FROM Products WHERE ProductName LIKE '%e%';
--Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.
SELECT * FROM Employees WHERE Department IN ('HR', 'IT', 'Finance');
--Write a query that finds employees who earn more than the average salary of all employees.
SELECT * FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees);
--Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.
SELECT * FROM Customers ORDER BY City ASC, PostalCode DESC;
HARD-LEVEL TASKS
--Write a query that selects the top 10 products with the highest sales, using TOP(10) and ordered by SalesAmount DESC.
SELECT TOP(10) * FROM Products ORDER BY SalesAmount DESC;
--Use COALESCE to combine FirstName and LastName into one column named FullName in the Employees table.
SELECT EmployeeID, COALESCE(FirstName + ' ' + LastName, FirstName, LastName, 'Unknown') AS FullName FROM Employees;
--Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.
SELECT DISTINCT Category, ProductName, Price FROM Products WHERE Price > 50;
--Write a query that selects products whose Price is within 10% of the average price in the Products table.
SELECT * FROM Products 
WHERE Price BETWEEN (SELECT AVG(Price) * 0.9 FROM Products) AND (SELECT AVG(Price) * 1.1 FROM Products);
--Use WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
SELECT * FROM Employees WHERE Age < 30 AND Department IN ('HR', 'IT');
--Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
SELECT * FROM Customers WHERE Email LIKE '%@gmail.com';
--Write a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.
SELECT * FROM Employees 
WHERE Salary > ALL (SELECT Salary FROM Employees WHERE Department = 'Sales');
--Use ORDER BY with OFFSET-FETCH to show employees with the highest salaries, displaying 10 employees at a time (pagination).
SELECT * FROM Employees ORDER BY Salary DESC OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
(For the next page, change OFFSET 0 to OFFSET 10, and so on.)
--Write a query that filters the Orders table for orders placed in the last 30 days using BETWEEN and CURRENT_DATE.
SELECT * FROM Orders WHERE OrderDate BETWEEN DATEADD(DAY, -30, CURRENT_TIMESTAMP) AND CURRENT_TIMESTAMP;
--Use ANY with a subquery to select all employees who earn more than the average salary for their department.
SELECT * FROM Employees 
WHERE Salary > ANY (SELECT AVG(Salary) FROM Employees GROUP BY Department);
