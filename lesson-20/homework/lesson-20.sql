
Question 1: Find customers who purchased at least one item in March 2024 using EXISTS

SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1 
    FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND MONTH(s2.SaleDate) = 3 AND YEAR(s2.SaleDate) = 2024
);


---

Question 2: Find the product with the highest total sales revenue using a subquery

SELECT Product
FROM (
    SELECT Product, SUM(Quantity * Price) AS TotalRevenue
    FROM #Sales
    GROUP BY Product
) AS RevenuePerProduct
WHERE TotalRevenue = (
    SELECT MAX(SUM(Quantity * Price))
    FROM #Sales
    GROUP BY Product
);


---

Question 3: Find the second highest sale amount using a subquery

SELECT MAX(SaleAmount) AS SecondHighestSale
FROM (
    SELECT Quantity * Price AS SaleAmount
    FROM #Sales
) AS SaleAmounts
WHERE SaleAmount < (
    SELECT MAX(Quantity * Price) FROM #Sales
);


---

Question 4: Find the total quantity of products sold per month using a subquery

SELECT MONTH(SaleDate) AS SaleMonth, SUM(Quantity) AS TotalQuantity
FROM #Sales
GROUP BY MONTH(SaleDate);


---

Question 5: Find customers who bought same products as another customer using EXISTS

SELECT DISTINCT f1.CustomerName
FROM #Sales f1
WHERE EXISTS (
    SELECT 1
    FROM #Sales f2
    WHERE f1.CustomerName <> f2.CustomerName AND f1.Product = f2.Product
);


---

Question 6: Count of each fruit per person

SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;


---

Question 7: Return older people in the family with younger ones

WITH RecursiveFamily AS (
    SELECT ParentID, ChildID FROM Family
    UNION ALL
    SELECT rf.ParentID, f.ChildID
    FROM RecursiveFamily rf
    JOIN Family f ON rf.ChildID = f.ParentID
)
SELECT DISTINCT ParentID, ChildID FROM RecursiveFamily;


---

Question 8: Customers with TX deliveries if they had CA delivery

SELECT * 
FROM #Orders o
WHERE DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1 
      FROM #Orders o2 
      WHERE o2.CustomerID = o.CustomerID AND o2.DeliveryState = 'CA'
  );


---

Question 9: Insert missing names into address

UPDATE #residents
SET address = address + ' name=' + fullname
WHERE address NOT LIKE '%name=%';


---

Question 10: Cheapest and most expensive routes from Tashkent to Khorezm

WITH Paths AS (
    SELECT 'Tashkent - Samarkand - Khorezm' AS Route, 100 + 400 AS Cost
    UNION ALL
    SELECT 'Tashkent - Jizzakh - Samarkand - Khorezm', 100 + 50 + 400
    UNION ALL
    SELECT 'Tashkent - Samarkand - Bukhoro - Khorezm', 100 + 200 + 300
)
SELECT * FROM Paths;


---

Question 11: Rank products based on insertion

WITH Grouped AS (
    SELECT ID, Vals,
           SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
           OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS GroupNum
    FROM #RankingPuzzle
)
SELECT * FROM Grouped WHERE Vals <> 'Product';


---

Question 12: Consecutive streaks

WITH Numbered AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY Id ORDER BY (SELECT NULL)) AS rn
    FROM #Consecutives
),
Groups AS (
    SELECT *, 
           Vals - ROW_NUMBER() OVER (PARTITION BY Id, Vals ORDER BY rn) AS grp
    FROM Numbered
),
MaxGroupLength AS (
    SELECT Id, Vals, COUNT(*) AS length
    FROM Groups
    GROUP BY Id, Vals, grp
),
NextNumber AS (
    SELECT Id, MAX(rn)+1 AS NextPosition
    FROM Numbered
    GROUP BY Id
)
SELECT mg.Id, 
       n.NextPosition AS NextNumber,
       MAX(mg.length) AS MaxConsecutiveLength
FROM MaxGroupLength mg
JOIN NextNumber n ON mg.Id = n.Id
GROUP BY mg.Id, n.NextPosition;


---

Question 13: Employees with sales above department average

SELECT *
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);


---

Question 14: Employees with highest sales in any month

SELECT *
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e.SalesMonth = e2.SalesMonth
      AND e.SalesYear = e2.SalesYear
    GROUP BY e2.SalesMonth, e2.SalesYear
    HAVING MAX(e2.SalesAmount) = e.SalesAmount
);


---

Question 15: Employees who made sales in every month

SELECT e.EmployeeName
FROM #EmployeeSales e
GROUP BY e.EmployeeName
HAVING COUNT(DISTINCT e.SalesMonth) = (
    SELECT COUNT(DISTINCT SalesMonth) FROM #EmployeeSales
);


---

Question 16: Products more expensive than average

SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);


---

Question 17: Products with stock < highest stock

SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);


---

Question 18: Products in the same category as 'Laptop'

SELECT Name
FROM Products
WHERE Category = (
    SELECT Category FROM Products WHERE Name = 'Laptop'
);


---

Question 19: Products more expensive than lowest price in Electronics

SELECT Name
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);


---

Question 20: Products that have both low stock and high price

SELECT *
FROM Products
WHERE Stock < (SELECT AVG(Stock) FROM Products)
  AND Price > (SELECT AVG(Price) FROM Products);
