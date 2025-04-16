--Easy Level
--1. Find all items that cost more than the average item price.
SELECT *
FROM Items
WHERE Price > (SELECT AVG(Price) FROM Items);
--2. List all staff members who work in divisions with more than 10 employees.
SELECT *
FROM Staff
WHERE DivisionID IN (
    SELECT DivisionID
    FROM Staff
    GROUP BY DivisionID
    HAVING COUNT(*) > 10
);
--3. Find staff who earn more than the average salary in their division.
(Use a correlated subquery.)
SELECT *
FROM Staff S1
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Staff S2
    WHERE S2.DivisionID = S1.DivisionID
);
4. List all clients who have made a purchase.
SELECT *
FROM Clients
WHERE ClientID IN (
    SELECT DISTINCT ClientID
    FROM Purchases
);
--5. Find all purchases that have at least one associated purchase detail.
(Use EXISTS.)
SELECT *
FROM Purchases P
WHERE EXISTS (
    SELECT 1
    FROM PurchaseDetails PD
    WHERE PD.PurchaseID = P.PurchaseID
);
6. List items that have been sold more than 100 times in total.
SELECT ItemID
FROM PurchaseDetails
GROUP BY ItemID
HAVING SUM(Quantity) > 100;
---7. List all staff who earn more than the average salary across the whole company.
SELECT *
FROM Staff
WHERE Salary > (SELECT AVG(Salary) FROM Staff);
---8. List vendors who supply items that cost less than $50.
SELECT DISTINCT VendorID
FROM Items
WHERE Price < 50;
---9. Find the maximum price among all items.
SELECT MAX(Price) AS MaxPrice
FROM Items;
---10. Find the purchase with the highest total amount.

SELECT MAX(TotalAmount) AS MaxPurchaseValue
FROM Purchases;
---11. List all clients who have never made a purchase.
SELECT *
FROM Clients
WHERE ClientID NOT IN (
    SELECT DISTINCT ClientID
    FROM Purchases
);
---12. List all items that belong to the "Electronics" category.
SELECT *
FROM Items
WHERE Category = 'Electronics';
---13. List all purchases made after January 1, 2024.
SELECT *
FROM Purchases
WHERE PurchaseDate > '2024-01-01';
---14. For each purchase, find the total number of items purchased.
SELECT PurchaseID, SUM(Quantity) AS TotalItems
FROM PurchaseDetails
GROUP BY PurchaseID;
---15. List all staff members who have been employed for more than 5 years.
SELECT *
FROM Staff
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 5; -- SQL Server
---16. (Same as #3) Find staff who earn more than the average salary in their division.
(Use a correlated subquery.)

SELECT *
FROM Staff S1
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Staff S2
    WHERE S2.DivisionID = S1.DivisionID
);
---17. List all purchases that include at least one item.
(Use EXISTS with JOIN.)
SELECT *
FROM Purchases P
WHERE EXISTS (
    SELECT 1
    FROM PurchaseDetails PD
    JOIN Items I ON I.ItemID = PD.ItemID
    WHERE PD.PurchaseID = P.PurchaseID
);
---18. List clients who made a purchase within the last 30 days.
SELECT *
FROM Clients
WHERE ClientID IN (
    SELECT DISTINCT ClientID
    FROM Purchases
    WHERE PurchaseDate >= CURRENT_DATE - INTERVAL '30 days'
);
---19. Find the oldest item based on creation date.

SELECT *
FROM Items
WHERE CreatedDate = (
    SELECT MIN(CreatedDate)
    FROM Items
);
---20. List staff members who are not assigned to any division.

SELECT *
FROM Staff
WHERE DivisionID IS NULL;
--Medium Level 
SELECT *
FROM Items
ORDER BY Price DESC
LIMIT 3;
---22. List all clients and the number of purchases they made.

SELECT C.ClientID, C.Name, COUNT(P.PurchaseID) AS PurchaseCount
FROM Clients C
LEFT JOIN Purchases P ON C.ClientID = P.ClientID
GROUP BY C.ClientID, C.Name;
---23. Find the average total amount of purchases per client.

SELECT ClientID, AVG(TotalAmount) AS AvgPurchase
FROM Purchases
GROUP BY ClientID;
---24. List items that were never sold.

SELECT *
FROM Items
WHERE ItemID NOT IN (
    SELECT DISTINCT ItemID
    FROM PurchaseDetails
);
---25. Find the division with the highest average salary.

SELECT DivisionID, AVG(Salary) AS AvgSalary
FROM Staff
GROUP BY DivisionID
ORDER BY AvgSalary DESC
LIMIT 1;
---26. Find purchases with more than 5 different items.

SELECT PurchaseID
FROM PurchaseDetails
GROUP BY PurchaseID
HAVING COUNT(DISTINCT ItemID) > 5;
---27. List clients whose total purchase amount exceeds $1000.

SELECT ClientID, SUM(TotalAmount) AS TotalSpent
FROM Purchases
GROUP BY ClientID
HAVING SUM(TotalAmount) > 1000;
---28. List vendors supplying more than 3 different items.

SELECT VendorID
FROM Items
GROUP BY VendorID
HAVING COUNT(DISTINCT ItemID) > 3;
---29. Find staff with the highest salary in each division.

SELECT *
FROM Staff S
WHERE Salary = (
    SELECT MAX(Salary)
    FROM Staff
    WHERE DivisionID = S.DivisionID
);
---30. List items sold in every month of the current year.

SELECT ItemID
FROM PurchaseDetails PD
JOIN Purchases P ON PD.PurchaseID = P.PurchaseID
WHERE EXTRACT(YEAR FROM P.PurchaseDate) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY ItemID
HAVING COUNT(DISTINCT EXTRACT(MONTH FROM P.PurchaseDate)) = 12;
---31. List divisions that have no staff.

SELECT *
FROM Divisions
WHERE DivisionID NOT IN (
    SELECT DISTINCT DivisionID
    FROM Staff
    WHERE DivisionID IS NOT NULL
);
---32. Find the average number of items per purchase.

SELECT AVG(ItemCount)
FROM (
    SELECT PurchaseID, SUM(Quantity) AS ItemCount
    FROM PurchaseDetails
    GROUP BY PurchaseID
) AS PurchaseItemCounts;
---33. List all items and how many times each was sold.

SELECT I.ItemID, I.Name, COALESCE(SUM(PD.Quantity), 0) AS TotalSold
FROM Items I
LEFT JOIN PurchaseDetails PD ON I.ItemID = PD.ItemID
GROUP BY I.ItemID, I.Name;
---34. Find the month with the most purchases.

SELECT EXTRACT(MONTH FROM PurchaseDate) AS Month, COUNT(*) AS TotalPurchases
FROM Purchases
GROUP BY EXTRACT(MONTH FROM PurchaseDate)
ORDER BY TotalPurchases DESC
LIMIT 1;
---35. Find clients who made multiple purchases on the same day.

SELECT ClientID, PurchaseDate, COUNT(*) AS PurchaseCount
FROM Purchases
GROUP BY ClientID, PurchaseDate
HAVING COUNT(*) > 1;
---36. Find staff who have the same salary as someone in another division.

SELECT DISTINCT S1.*
FROM Staff S1
JOIN Staff S2
  ON S1.Salary = S2.Salary AND S1.DivisionID != S2.DivisionID;
---37. Find the most common item in purchases.

SELECT ItemID, SUM(Quantity) AS Total
FROM PurchaseDetails
GROUP BY ItemID
ORDER BY Total DESC
LIMIT 1;
---38. List the top 5 clients by total spending.
SELECT ClientID, SUM(TotalAmount) AS TotalSpent
FROM Purchases
GROUP BY ClientID
ORDER BY TotalSpent DESC
LIMIT 5;
---39. Find average salary per division for divisions with more than 5 staff.

SELECT DivisionID, AVG(Salary) AS AvgSalary
FROM Staff
GROUP BY DivisionID
HAVING COUNT(*) > 5;
---40. List purchases that only include items from one category.

SELECT PD.PurchaseID
FROM PurchaseDetails PD
JOIN Items I ON PD.ItemID = I.ItemID
GROUP BY PD.PurchaseID
HAVING COUNT(DISTINCT I.Category) = 1;
---41. List items that have been sold to more than 10 different clients.

SELECT PD.ItemID
FROM PurchaseDetails PD
JOIN Purchases P ON PD.PurchaseID = P.PurchaseID
GROUP BY PD.ItemID
HAVING COUNT(DISTINCT P.ClientID) > 10;
---42. Find average time between purchases for each client.

SELECT ClientID, AVG(DIFF) AS AvgDaysBetween
FROM (
    SELECT ClientID,
           DATEDIFF(DAY, LAG(PurchaseDate) OVER (PARTITION BY ClientID ORDER BY PurchaseDate), PurchaseDate) AS DIFF
    FROM Purchases
) AS DiffTable
WHERE DIFF IS NOT NULL
GROUP BY ClientID;

---43. Find vendors who supply only one item.

SELECT VendorID
FROM Items
GROUP BY VendorID
HAVING COUNT(*) = 1;
--44. List items that were never restocked but were sold.

SELECT DISTINCT ItemID
FROM PurchaseDetails
WHERE ItemID NOT IN (
    SELECT DISTINCT ItemID
    FROM Restocks
);

---45. List clients who bought the same item more than once.

SELECT P.ClientID, PD.ItemID
FROM Purchases P
JOIN PurchaseDetails PD ON P.PurchaseID = PD.PurchaseID
GROUP BY P.ClientID, PD.ItemID
HAVING COUNT(*) > 1;
---46. Find top-selling item per category.
SELECT Category, ItemID, TotalSold
FROM (
    SELECT I.Category, I.ItemID, SUM(PD.Quantity) AS TotalSold,
           RANK() OVER (PARTITION BY I.Category ORDER BY SUM(PD.Quantity) DESC) AS rk
    FROM Items I
    JOIN PurchaseDetails PD ON I.ItemID = PD.ItemID
    GROUP BY I.Category, I.ItemID
) AS Ranked
WHERE rk = 1;
---47. Find purchases where all items are from the same vendor.

SELECT PD.PurchaseID
FROM PurchaseDetails PD
JOIN Items I ON PD.ItemID = I.ItemID
GROUP BY PD.PurchaseID
HAVING COUNT(DISTINCT I.VendorID) = 1;
---48. List clients who only bought items from one category.

SELECT P.ClientID
FROM Purchases P
JOIN PurchaseDetails PD ON P.PurchaseID = PD.PurchaseID
JOIN Items I ON PD.ItemID = I.ItemID
GROUP BY P.ClientID
HAVING COUNT(DISTINCT I.Category) = 1;
---49. Find items with increasing monthly sales over the last 3 months.

WITH MonthlySales AS (
    SELECT ItemID, EXTRACT(MONTH FROM P.PurchaseDate) AS Month,
           SUM(PD.Quantity) AS Total
    FROM PurchaseDetails PD
    JOIN Purchases P ON PD.PurchaseID = P.PurchaseID
    WHERE P.PurchaseDate >= CURRENT_DATE - INTERVAL '3 months'
    GROUP BY ItemID, EXTRACT(MONTH FROM P.PurchaseDate)
)
SELECT ItemID
FROM MonthlySales
GROUP BY ItemID
HAVING COUNT(*) = 3 AND
       MIN(Total) < AVG(Total) AND
       MAX(Total) > AVG(Total);
---50. List the 3 most popular categories by number of items sold.
SELECT I.Category, SUM(PD.Quantity) AS TotalSold
FROM PurchaseDetails PD
JOIN Items I ON PD.ItemID = I.ItemID
GROUP BY I.Category
ORDER BY TotalSold DESC
LIMIT 3;


