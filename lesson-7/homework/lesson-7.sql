Easy-Level Tasks (10) 
--1. Write a query to find the minimum (MIN) price of a product in the Products table. 
SELECT MIN(Price) AS Min_Price FROM Products;
--2. Write a query to find the maximum (MAX) Salary from the Employees table. 
SELECT MAX(Salary) AS Max_Salary FROM Employees;
--3. Write a query to count the number of rows in the Customers table using COUNT(*). 
SELECT COUNT(*) AS Total_Customers FROM Customers;
--4. Write a query to count the number of unique product categories (COUNT(DISTINCT Category)) from the Products table. 
SELECT COUNT(DISTINCT Category) AS Unique_Categories FROM Products;
--5. Write a query to find the total (SUM) sales for a particular product in the Sales table.
SELECT SUM(Sales_Amount) AS Total_Sales FROM Sales WHERE Product_ID = 'Your_Product_ID';
--6. Write a query to calculate the average (AVG) age of employees in the Employees table.
SELECT AVG(Age) AS Average_Age FROM Employees;
--7. Write a query that uses GROUP BY to count the number of employees in each department. 
SELECT Department, COUNT(*) AS Employee_Count  
FROM Employees  
GROUP BY Department;
--8. Write a query to show the minimum and maximum Price of products grouped by Category.
SELECT Category, MIN(Price) AS Min_Price, MAX(Price) AS Max_Price  
FROM Products  
GROUP BY Category;
--9. Write a query to calculate the total (SUM) sales per Region in the Sales table. 
SELECT Region, SUM(Sales_Amount) AS Total_Sales  
FROM Sales  
GROUP BY Region;
--10. Write a query to use HAVING to filter departments having more than 5 employees from the Employees table.
SELECT Department, COUNT(*) AS Employee_Count  
FROM Employees  
GROUP BY Department  
HAVING COUNT(*) > 5;
MEDIUM-LEVEL TASKS
--11. Write a query to calculate the total sales and average sales for each product category from the Sales table. 
SELECT Category, SUM(Sales_Amount) AS Total_Sales, AVG(Sales_Amount) AS Average_Sales  
FROM Sales  
GROUP BY Category;
--12. Write a query that uses COUNT(columnname) to count the number of employees with a specific JobTitle. 
SELECT COUNT(JobTitle) AS Employee_Count  
FROM Employees  
WHERE JobTitle = 'Software Engineer';
--13. Write a query that finds the highest (MAX) and lowest (MIN) Salary by department in the Employees table. 
SELECT Department, MAX(Salary) AS Max_Salary, MIN(Salary) AS Min_Salary  
FROM Employees  
GROUP BY Department;
--14. Write a query that uses GROUP BY to calculate the average salary per Department. 
SELECT Department, AVG(Salary) AS Avg_Salary  
FROM Employees  
GROUP BY Department;
--15. Write a query to show the AVG salary and COUNT(*) of employees working in each department.
SELECT Department, AVG(Salary) AS Avg_Salary, COUNT(*) AS Employee_Count  
FROM Employees  
GROUP BY Department;
--16. Write a query that uses HAVING to filter products with an average price greater than 100.
SELECT ProductID, AVG(Price) AS Avg_Price  
FROM Products  
GROUP BY ProductID  
HAVING AVG(Price) > 100;
--17. Write a query to count how many products have sales above 100 units using COUNT(DISTINCT ProductID).
SELECT COUNT(DISTINCT ProductID) AS Product_Count  
FROM Sales  
WHERE Quantity > 100;
--18. Write a query that calculates the total sales for each year in the Sales table, and use GROUP BY to group them.
SELECT YEAR(Sale_Date) AS Year, SUM(Sales_Amount) AS Total_Sales  
FROM Sales  
GROUP BY YEAR(Sale_Date);
--19. Write a query that uses COUNT to show the number of customers who placed orders in each region. 
SELECT Region, COUNT(DISTINCT CustomerID) AS Customer_Count  
FROM Orders  
GROUP BY Region;
--20. Write a query that applies the HAVING clause to filter out Departments with total salary expenses greater than 100,000.
SELECT Department, SUM(Salary) AS Total_Salary  
FROM Employees  
GROUP BY Department  
HAVING SUM(Salary) > 100000;
Hard-Level Tasks (10) 
--21. Write a query that shows the average (AVG) sales for each product category, and then uses HAVING to filter categories with an average sales amount greater than 200.
SELECT JobTitle, COUNT(*) AS Employee_Count, AVG(Salary) AS Avg_Salary  
FROM Employees  
GROUP BY JobTitle;
--22. Write a query to calculate the total (SUM) sales for each employee, then filter the results using HAVING to include only employees with total sales over 5000. 
SELECT Department, SUM(Salary) AS Total_Salary  
FROM Employees  
GROUP BY Department  
ORDER BY Total_Salary DESC  
LIMIT 1;
--23. Write a query to find the total (SUM) and average (AVG) salary of employees grouped by department, and use HAVING to include only departments with an average salary greater than 6000.
SELECT YEAR(Hire_Date) AS Hire_Year, COUNT(*) AS Employee_Count  
FROM Employees  
GROUP BY YEAR(Hire_Date)  
ORDER BY Hire_Year ASC;
--24. Write a query that finds the maximum (MAX) and minimum (MIN) order value for each customer, and then applies HAVING to exclude customers with an order value less than 50.
SELECT JobTitle, COUNT(*) AS Job_Count  
FROM Employees  
GROUP BY JobTitle  
ORDER BY Job_Count DESC  
LIMIT 1;
--25. Write a query that calculates the total sales (SUM) and counts distinct products sold in each Region, and then applies HAVING to filter regions with more than 10 products sold.
SELECT Region, MAX(Sales_Amount) AS Max_Sales, MIN(Sales_Amount) AS Min_Sales, AVG(Sales_Amount) AS Avg_Sales  
FROM Sales  
GROUP BY Region;
--26. Write a query to find the MIN and MAX order quantity per product, and then use GROUP BY to group the results by ProductCategory.
SELECT CustomerID, COUNT(OrderID) AS Total_Orders  
FROM Orders  
GROUP BY CustomerID  
ORDER BY Total_Orders DESC;
