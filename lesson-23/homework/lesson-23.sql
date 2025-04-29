
Puzzle 1: Extract and prefix month with zero

SELECT 
    Id, 
    Dt, 
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR), 2) AS MonthPrefixedWithZero
FROM Dates;


---

Puzzle 2: Unique Ids and sum of max Vals per (Id, rID)

SELECT 
    COUNT(DISTINCT Id) AS Distinct_Ids, 
    rID, 
    SUM(MaxVal) AS TotalOfMaxVals
FROM (
    SELECT Id, rID, MAX(Vals) AS MaxVal
    FROM MyTabel
    GROUP BY Id, rID
) AS MaxVals
GROUP BY rID;


---

Puzzle 3: Length of Vals between 6 and 10

SELECT * 
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;


---

Puzzle 4: Max value row for each ID in single SELECT

SELECT *
FROM TestMaximum t
WHERE Vals = (
    SELECT MAX(Vals) 
    FROM TestMaximum 
    WHERE ID = t.ID
);


---

Puzzle 5: Sum of max Vals per Id and DetailedNumber

SELECT Id, SUM(MaxVal) AS SumofMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) AS Sub
GROUP BY Id;


---

Puzzle 6: Difference a - b, replace 0 with blank

SELECT 
    Id, 
    a, 
    b, 
    CASE 
        WHEN a - b = 0 THEN '' 
        ELSE CAST(a - b AS VARCHAR)
    END AS OUTPUT
FROM TheZeroPuzzle;


---

Analytics – Sales Table

7. Total revenue from all sales:

SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue FROM Sales;

8. Average unit price:

SELECT AVG(UnitPrice) AS AverageUnitPrice FROM Sales;

9. Number of sales transactions:

SELECT COUNT(*) AS TransactionCount FROM Sales;

10. Highest quantity sold in a transaction:

SELECT MAX(QuantitySold) AS MaxUnitsSold FROM Sales;

11. Products sold per category:

SELECT Category, SUM(QuantitySold) AS TotalSold FROM Sales GROUP BY Category;

12. Revenue per region:

SELECT Region, SUM(QuantitySold * UnitPrice) AS TotalRevenue FROM Sales GROUP BY Region;

13. Total quantity sold per month:

SELECT FORMAT(SaleDate, 'yyyy-MM') AS Month, SUM(QuantitySold) AS TotalQty
FROM Sales
GROUP BY FORMAT(SaleDate, 'yyyy-MM');

14. Product generating highest revenue:

SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY Product
ORDER BY Revenue DESC;

15. Running total of revenue by sale date:

SELECT 
    SaleDate, 
    Product,
    QuantitySold * UnitPrice AS Revenue,
    SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) AS RunningTotal
FROM Sales;

16. Category contribution to total revenue:

SELECT 
    Category, 
    SUM(QuantitySold * UnitPrice) AS Revenue,
    CAST(SUM(QuantitySold * UnitPrice) * 100.0 / SUM(SUM(QuantitySold * UnitPrice)) OVER () AS DECIMAL(5,2)) AS PercentageContribution
FROM Sales
GROUP BY Category;


---

Analytics – Sales + Customers

Assuming there's a linking table or logic (e.g., based on Region):

17. Sales with customer names (assuming join via Region):

SELECT s.*, c.CustomerName
FROM Sales s
JOIN Customers c ON s.Region = c.Region;

18. Customers with no purchases (again, based on Region logic):

SELECT c.*
FROM Customers c
LEFT JOIN Sales s ON c.Region = s.Region
WHERE s.SaleID IS NULL;

19. Revenue per customer (based on Region):

SELECT c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) AS Revenue
FROM Customers c
JOIN Sales s ON c.Region = s.Region
GROUP BY c.CustomerName;

20. Top contributing customer (by revenue):

SELECT TOP 1 c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) AS Revenue
FROM Customers c
JOIN Sales s ON c.Region = s.Region
GROUP BY c.CustomerName
ORDER BY Revenue DESC;

21. Sales per customer per month:

SELECT 
    c.CustomerName, 
    FORMAT(s.SaleDate, 'yyyy-MM') AS SaleMonth, 
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Customers c
JOIN Sales s ON c.Region = s.Region
GROUP BY c.CustomerName, FORMAT(s.SaleDate, 'yyyy-MM');


---

Analytics – Products Table

22. Products sold at least once:

SELECT DISTINCT p.ProductName
FROM Products p
JOIN Sales s ON s.Product = p.ProductName;

23. Most expensive product:

SELECT TOP 1 * FROM Products ORDER BY SellingPrice DESC;

24. Sale with corresponding cost price:

SELECT s.*, p.CostPrice
FROM Sales s
JOIN Products p ON s.Product = p.ProductName;

25. Products with price > average in category:

SELECT * 
FROM Products p
WHERE SellingPrice > (
    SELECT AVG(SellingPrice)
    FROM Products
    WHERE Category = p.Category
);


