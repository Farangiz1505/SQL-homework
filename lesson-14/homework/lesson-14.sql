Easy Tasks

1. Create a numbers table using a recursive query.

WITH Numbers AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 1
    FROM Numbers
    WHERE Number < 100 -- Limit to desired number, for example 100
)
SELECT * FROM Numbers;

This recursive query generates a numbers table starting from 1 and increments by 1. You can change the condition WHERE Number < 100 to any other value to generate more or fewer numbers.

2. Beginning at 1, this script uses a recursive statement to double the number for each record.

WITH DoubledNumbers AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number * 2
    FROM DoubledNumbers
    WHERE Number < 1000 -- You can change the limit as needed
)
SELECT * FROM DoubledNumbers;

This query doubles the number for each record, starting from 1.

3. Write a query to find the total sales per employee using a derived table.

SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY EmployeeID;

The derived table isn't strictly necessary here because we can directly calculate the sum in the query, but if you wanted to use a derived table, you could do something like:

SELECT EmployeeID, TotalSales
FROM (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS DerivedTable;

4. Create a CTE to find the average salary of employees.

WITH AverageSalary AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT * FROM AverageSalary;

The CTE calculates the average salary from the Employees table and then selects it.

5. Write a query using a derived table to find the highest sales for each product.

SELECT ProductID, MAX(SalesAmount) AS HighestSales
FROM (
    SELECT ProductID, SalesAmount
    FROM Sales
) AS DerivedTable
GROUP BY ProductID;

This query first creates a derived table and then groups by ProductID to find the highest sales amount.

6. Use a CTE to get the names of employees who have made more than 5 sales.

WITH SalesCount AS (
    SELECT EmployeeID, COUNT(*) AS SalesMade
    FROM Sales
    GROUP BY EmployeeID
)
SELECT E.FirstName, E.LastName
FROM Employees E
JOIN SalesCount SC ON E.EmployeeID = SC.EmployeeID
WHERE SC.SalesMade > 5;

This CTE counts the sales for each employee, then selects the employees who made more than 5 sales.

7. Write a query using a CTE to find all products with sales greater than $500.

WITH HighSales AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT P.ProductName, HS.TotalSales
FROM HighSales HS
JOIN Products P ON HS.ProductID = P.ProductID
WHERE HS.TotalSales > 500;

This CTE calculates the total sales for each product, then filters the products that have sales greater than $500.

8. Create a CTE to find employees with salaries above the average salary.

WITH AvgSalary AS (
    SELECT AVG(Salary) AS AverageSalary
    FROM Employees
)
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > (SELECT AverageSalary FROM AvgSalary);

This CTE calculates the average salary, then filters employees whose salaries are above that average.

9. Write a query to find the total number of products sold using a derived table.

SELECT SUM(TotalSold) AS TotalProductsSold
FROM (
    SELECT ProductID, COUNT(*) AS TotalSold
    FROM Sales
    GROUP BY ProductID
) AS DerivedTable;

The derived table calculates the number of sales for each product, and then the outer query sums up the total number of products sold.

10. Use a CTE to find the names of employees who have not made any sales.

WITH EmployeeSales AS (
    SELECT EmployeeID
    FROM Sales
    GROUP BY EmployeeID
)
SELECT E.FirstName, E.LastName
FROM Employees E
LEFT JOIN EmployeeSales ES ON E.EmployeeID = ES.EmployeeID
WHERE ES.EmployeeID IS NULL;

This CTE finds all employees who have made sales, and the LEFT JOIN returns those employees who do not have any sales.


--Medium Tasks

1. Recursion to Calculate Factorials

Question: Write a query using recursion to calculate factorials.

Solution:

WITH Factorial (Number, Fact) AS
(
    SELECT 1, 1
    UNION ALL
    SELECT Number + 1, Fact * (Number + 1)
    FROM Factorial
    WHERE Number < 5
)
SELECT * FROM Factorial;

This CTE calculates factorials from 1! to 5!.


---

2. Recursion to Calculate Fibonacci Numbers

Question: Write a query using recursion to calculate Fibonacci numbers.

Solution:

WITH Fibonacci (Position, Value) AS
(
    SELECT 1, 1
    UNION ALL
    SELECT 2, 1
    UNION ALL
    SELECT Position + 1, Value + (SELECT Value FROM Fibonacci WHERE Position = Position - 1)
    FROM Fibonacci
    WHERE Position < 10
)
SELECT * FROM Fibonacci;

This CTE generates the first 10 Fibonacci numbers.


---

3. Recursion to Split a String into Rows of Substrings

Question: Write a query using recursion to split a string into rows of substrings for each character in the string.

Solution:

WITH SplitString (Position, Char) AS
(
    SELECT 1, SUBSTRING('abcdefghi', 1, 1)
    UNION ALL
    SELECT Position + 1, SUBSTRING('abcdefghi', Position + 1, 1)
    FROM SplitString
    WHERE Position < LEN('abcdefghi')
)
SELECT * FROM SplitString;

This query splits the string 'abcdefghi' into individual characters and returns them as rows.


---

4. Rank Employees Based on Total Sales

Question: Create a CTE to rank employees based on their total sales.

Solution:

WITH EmployeeSales AS
(
    SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(s.SalesAmount) AS TotalSales
    FROM Employees e
    JOIN Sales s ON e.EmployeeID = s.EmployeeID
    GROUP BY e.EmployeeID, e.FirstName, e.LastName
)
SELECT *, RANK() OVER (ORDER BY TotalSales DESC) AS SalesRank
FROM EmployeeSales;

This CTE calculates the total sales for each employee and ranks them accordingly.


---

5. Top 5 Employees by Number of Orders Made

Question: Write a query using a derived table to find the top 5 employees by the number of orders made.

Solution:

SELECT TOP 5 e.EmployeeID, e.Name, COUNT(o.OrderID) AS OrdersMade
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.Name
ORDER BY OrdersMade DESC;

This query ranks the top 5 employees based on the number of orders they've processed.


---

Difficult Tasks

6. Find the Employees Who Have the Most Similar Sales to Their Colleagues

Question: Write a query to find the employees whose sales numbers are most similar to others' sales in the department.

Solution:

WITH SalesDifference AS
(
    SELECT e.EmployeeID, e.DepartmentID, e.Name, s.SalesAmount,
           ABS(s.SalesAmount - (SELECT AVG(SalesAmount) FROM Sales WHERE DepartmentID = e.DepartmentID)) AS SalesDifference
    FROM Employees e
    JOIN Sales s ON e.EmployeeID = s.EmployeeID
)
SELECT EmployeeID, Name, DepartmentID, SalesAmount, SalesDifference
FROM SalesDifference
WHERE SalesDifference = (SELECT MIN(SalesDifference) FROM SalesDifference WHERE DepartmentID = SalesDifference.DepartmentID)
ORDER BY DepartmentID;

This query finds the employees whose sales are closest to the average sales in their department.


---

7. Find the Most Expensive Products Bought by Each Customer

Question: Write a query to find the most expensive product bought by each customer.

Solution:

WITH CustomerPurchases AS
(
    SELECT c.CustomerID, p.ProductName, o.OrderID, op.Quantity, op.UnitPrice,
           ROW_NUMBER() OVER (PARTITION BY c.CustomerID ORDER BY op.UnitPrice DESC) AS RowNum
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderProducts op ON o.OrderID = op.OrderID
    JOIN Products p ON op.ProductID = p.ProductID
)
SELECT CustomerID, ProductName, UnitPrice
FROM CustomerPurchases
WHERE RowNum = 1;

This query finds the most expensive product purchased by each customer.


---

8. Recursive Query to Find a Chain of Managers

Question: Write a recursive query to find a chain of managers for a given employee.

Solution:

WITH ManagerChain AS
(
    SELECT EmployeeID, ManagerID, Name
    FROM Employees
    WHERE EmployeeID = 5
    UNION ALL
    SELECT e.EmployeeID, e.ManagerID, e.Name
    FROM Employees e
    JOIN ManagerChain m ON e.EmployeeID = m.ManagerID
)
SELECT * FROM ManagerChain;

This query recursively finds the manager chain starting from the employee with EmployeeID = 5.


---

9. Calculate Running Total of Sales for Each Product

Question: Write a query to calculate the running total of sales for each product.

Solution:

WITH RunningTotal AS
(
    SELECT ProductID, SalesDate, SalesAmount,
           SUM(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SalesDate) AS RunningSales
    FROM Sales
)
SELECT ProductID, SalesDate, SalesAmount, RunningSales
FROM RunningTotal;

This query calculates the running total of sales for each product, ordered by the sales date.


---

10. Create a CTE for Finding the Maximum Price for Each Category

Question: Write a query using a CTE to find the maximum price for each category.

Solution:

WITH CategoryMaxPrice AS
(
    SELECT CategoryID, MAX(Price) AS MaxPrice
    FROM Products
    GROUP BY CategoryID
)
SELECT c.CategoryID, c.MaxPrice, p.ProductName
FROM CategoryMaxPrice c
JOIN Products p ON c.CategoryID = p.CategoryID
WHERE p.Price = c.MaxPrice;

This CTE finds the most expensive product for each category by first calculating the maximum price and then joining it with the products table.






