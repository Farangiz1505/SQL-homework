-- Task 1
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100)
);

-- Task 2
CREATE TABLE Items (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(100),
    Price DECIMAL(10,2),
    Quantity INT
);

-- Task 3
CREATE TABLE Purchases (
    PurchaseID INT PRIMARY KEY,
    ClientID INT,
    ItemID INT,
    PurchaseDate DATE,
    Quantity INT,
    Amount DECIMAL(10,2),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

-- Task 4
INSERT INTO Clients VALUES (1, 'John Doe', 'john@example.com');

-- Task 5
INSERT INTO Items VALUES (1, 'Laptop', 1200.00, 10);

-- Task 6
INSERT INTO Purchases VALUES (1, 1, 1, '2024-01-10', 1, 1200.00);

-- Task 7
SELECT * FROM Purchases WHERE PurchaseDate BETWEEN '2024-01-01' AND '2024-01-31';

-- Task 8
SELECT Name FROM Clients WHERE ClientID IN (SELECT ClientID FROM Purchases WHERE ItemID = 1);

-- Task 9
SELECT ItemName FROM Items WHERE ItemID IN (SELECT ItemID FROM Purchases GROUP BY ItemID HAVING COUNT(*) > 1);

-- Task 10
UPDATE Items SET Price = Price * 0.9;

-- Task 11
DELETE FROM Purchases WHERE PurchaseDate < '2023-01-01';

-- Task 12
SELECT i.ItemName, SUM(p.Amount) AS TotalSales
FROM Purchases p
JOIN Items i ON p.ItemID = i.ItemID
GROUP BY i.ItemName;

-- Task 13
SELECT ClientID, COUNT(*) AS TotalPurchases
FROM Purchases
GROUP BY ClientID;

-- Task 14
SELECT TOP 1 ClientID, SUM(Amount) AS TotalSpent
FROM Purchases
GROUP BY ClientID
ORDER BY TotalSpent DESC;

-- Task 15
SELECT * FROM Purchases
WHERE ClientID = 1
ORDER BY PurchaseDate DESC;

-- Task 16
SELECT c.Name, i.ItemName, p.PurchaseDate
FROM Purchases p
JOIN Clients c ON p.ClientID = c.ClientID
JOIN Items i ON p.ItemID = i.ItemID;

-- Task 17
SELECT i.ItemName, COUNT(p.PurchaseID) AS PurchaseCount
FROM Items i
LEFT JOIN Purchases p ON i.ItemID = p.ItemID
GROUP BY i.ItemName;

-- Task 18
SELECT ItemID, AVG(Amount) AS AvgSpent
FROM Purchases
GROUP BY ItemID;

-- Task 19
SELECT c.ClientID, c.Name, COUNT(p.PurchaseID) AS PurchaseCount
FROM Clients c
LEFT JOIN Purchases p ON c.ClientID = p.ClientID
GROUP BY c.ClientID, c.Name;

-- Task 20
SELECT ItemName
FROM Items
WHERE ItemID NOT IN (SELECT DISTINCT ItemID FROM Purchases);

-- Task 21
SELECT ClientID
FROM Purchases
GROUP BY ClientID
HAVING SUM(Amount) > 2000;

-- Task 22
SELECT ClientID, MAX(Amount) AS MaxSpent
FROM Purchases
GROUP BY ClientID;

-- Task 23
SELECT i.ItemName, SUM(p.Quantity) AS TotalSold
FROM Purchases p
JOIN Items i ON p.ItemID = i.ItemID
GROUP BY i.ItemName;

-- Task 24
SELECT c.ClientID, c.Name, SUM(p.Amount) AS TotalSpent
FROM Clients c
JOIN Purchases p ON c.ClientID = p.ClientID
GROUP BY c.ClientID, c.Name;

-- Task 25
SELECT c.ClientID, c.Name, COUNT(DISTINCT p.ItemID) AS ItemsBought
FROM Clients c
JOIN Purchases p ON c.ClientID = p.ClientID
GROUP BY c.ClientID, c.Name;

-- Task 26
SELECT ItemID, COUNT(*) AS PurchaseCount
FROM Purchases
GROUP BY ItemID
ORDER BY PurchaseCount DESC;

-- Task 27
SELECT ClientID, SUM(Amount) AS Total
FROM Purchases
WHERE PurchaseDate >= '2024-01-01'
GROUP BY ClientID;

-- Task 28
SELECT c.ClientID, c.Name, COUNT(p.PurchaseID) AS PurchaseCount
FROM Clients c
JOIN Purchases p ON c.ClientID = p.ClientID
GROUP BY c.ClientID, c.Name;

-- Task 29
SELECT ItemID, Price
FROM Items
WHERE Price = (SELECT MAX(Price) FROM Items);

-- Task 30
SELECT c.ClientID, c.Name, SUM(p.Quantity) AS TotalQuantity
FROM Clients c
JOIN Purchases p ON c.ClientID = p.ClientID
GROUP BY c.ClientID, c.Name;

-- Task 31
CREATE TRIGGER trgUpdateStockOnPurchase
ON Purchases
AFTER INSERT
AS
BEGIN
    UPDATE i
    SET i.Quantity = i.Quantity - p.Quantity
    FROM Items i
    JOIN inserted p ON i.ItemID = p.ItemID;
END;

-- Task 32
SELECT ClientID
FROM Purchases
GROUP BY ClientID
HAVING COUNT(DISTINCT ItemID) = (SELECT COUNT(*) FROM Items);

-- Task 33
CREATE FUNCTION fnClientAverageMonthlySpend (@clientID INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @average MONEY;
    SELECT @average = AVG(MonthlySpend)
    FROM (
        SELECT YEAR(PurchaseDate) AS Yr, MONTH(PurchaseDate) AS Mn, SUM(Amount) AS MonthlySpend
        FROM Purchases
        WHERE ClientID = @clientID
        GROUP BY YEAR(PurchaseDate), MONTH(PurchaseDate)
    ) AS MonthlyTotals;
    
    RETURN @average;
END;

-- Task 34
CREATE VIEW vwTopClientsPerItem AS
SELECT ItemID, ClientID, TotalAmount
FROM (
    SELECT ItemID, ClientID, SUM(Amount) AS TotalAmount,
           RANK() OVER (PARTITION BY ItemID ORDER BY SUM(Amount) DESC) AS rk
    FROM Purchases
    GROUP BY ItemID, ClientID
) AS Ranked
WHERE rk = 1;

-- Task 35
WITH PurchaseCTE AS (
    SELECT ClientID, PurchaseDate, Amount,
           ROW_NUMBER() OVER (PARTITION BY ClientID ORDER BY PurchaseDate) AS rn
    FROM Purchases
),
RecursiveCTE AS (
    SELECT ClientID, PurchaseDate, Amount, rn, Amount AS RunningTotal
    FROM PurchaseCTE
    WHERE rn = 1

    UNION ALL

    SELECT p.ClientID, p.PurchaseDate, p.Amount, p.rn,
           r.RunningTotal + p.Amount
    FROM PurchaseCTE p
    JOIN RecursiveCTE r ON p.ClientID = r.ClientID AND p.rn = r.rn + 1
)
SELECT ClientID, PurchaseDate, Amount, RunningTotal
FROM RecursiveCTE
ORDER BY ClientID, PurchaseDate;
