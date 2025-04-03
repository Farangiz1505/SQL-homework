--Task 1: Basic INNER JOIN.Retrieve all employee names along with their corresponding department names.
SELECT Employees.Name, Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;
--Task 2: LEFT JOIN.List all students along with their class names, including students who are not assigned to any class.
SELECT Students.StudentName, Classes.ClassName
FROM Students
LEFT JOIN Classes ON Students.ClassID = Classes.ClassID;
--Task 3: RIGHT JOIN.List all customers and their orders, including customers who haven’t placed any orders.
SELECT Customers.CustomerName, Orders.OrderID, Orders.OrderDate
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
--Task 4: FULL OUTER JOIN.Retrieve all products and their sales, including products with no sales and sales with invalid product references.
SELECT Products.ProductName, Sales.Quantity
FROM Products
FULL OUTER JOIN Sales ON Products.ProductID = Sales.ProductID;
Note: If FULL OUTER JOIN is not supported, use:
SELECT Products.ProductName, Sales.Quantity
FROM Products
LEFT JOIN Sales ON Products.ProductID = Sales.ProductID
UNION
SELECT Products.ProductName, Sales.Quantity
FROM Products
RIGHT JOIN Sales ON Products.ProductID = Sales.ProductID;
--Task 5: SELF JOIN.Find the names of employees along with the names of their managers.
SELECT E1.Name AS Employee, E2.Name AS Manager
FROM Employees E1
LEFT JOIN Employees E2 ON E1.ManagerID = E2.EmployeeID;
--Task 6: CROSS JOIN.Generate all possible combinations of colors and sizes.
SELECT Colors.ColorName, Sizes.SizeName
FROM Colors
CROSS JOIN Sizes;
--Task 7: JOIN with WHERE Clause.Find all movies released after 2015 and their associated actors.
SELECT Movies.Title, Actors.Name AS Actor
FROM Movies
INNER JOIN Actors ON Movies.MovieID = Actors.MovieID
WHERE Movies.ReleaseYear > 2015;
--Task 8: MULTIPLE JOINS.Retrieve the order date, customer name, and the product ID for all orders.
SELECT Orders.OrderDate, Customers.CustomerName, OrderDetails.ProductID
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID;
--Task 9: JOIN with Aggregation.Calculate the total revenue generated for each product.
SELECT Products.ProductName, SUM(Sales.Quantity * Products.Price) AS TotalRevenue
FROM Sales
INNER JOIN Products ON Sales.ProductID = Products.ProductID
GROUP BY Products.ProductName;

