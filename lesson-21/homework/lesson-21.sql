ProductSales Table Tasks:

1. Assign row number by SaleDate

SELECT *, ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;

2. Rank products by total quantity sold

SELECT ProductName, SUM(Quantity) AS TotalQty,
       DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS Rank
FROM ProductSales
GROUP BY ProductName;

3. Top sale for each customer

SELECT *
FROM (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) AS Ranked
WHERE rn = 1;

4. Sale amount with next sale's amount

SELECT SaleID, SaleAmount, 
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales;

5. Sale amount with previous sale's amount

SELECT SaleID, SaleAmount, 
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales;

6. Rank sale amount within each product

SELECT *, 
       RANK() OVER (PARTITION BY ProductName ORDER BY SaleAmount DESC) AS SaleRank
FROM ProductSales;

7. Sales greater than previous sale

SELECT *, 
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales
WHERE SaleAmount > LAG(SaleAmount) OVER (ORDER BY SaleDate);

8. Difference in sale amount from previous sale per product

SELECT *, 
       SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromPrev
FROM ProductSales;

9. % change from current to next sale

SELECT *, 
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextAmount,
       CAST(LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount AS FLOAT) 
       / NULLIF(SaleAmount, 0) * 100 AS PercentageChange
FROM ProductSales;

10. Ratio of current to previous sale per product

SELECT *, 
       CAST(SaleAmount AS FLOAT) / NULLIF(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 0) AS Ratio
FROM ProductSales;

11. Difference from first sale of the product

SELECT *, 
       SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirst
FROM ProductSales;

12. Continuously increasing sales per product

SELECT *, 
       LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevSale
FROM ProductSales
WHERE SaleAmount > LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate);

13. Closing balance (running total)

SELECT *, 
       SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ClosingBalance
FROM ProductSales;

14. Moving average over last 3 sales

SELECT *, 
       AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM ProductSales;

15. Difference between sale amount and average

SELECT *, 
       SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales;


---

Employees1 Table Tasks:

16. Employees with same salary rank

SELECT *, 
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees1;

17. Top 2 highest salaries per department

SELECT *
FROM (
    SELECT *, 
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RankInDept
    FROM Employees1
) AS Ranked
WHERE RankInDept <= 2;

18. Lowest-paid employee in each department

SELECT *
FROM (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rn
    FROM Employees1
) AS Ranked
WHERE rn = 1;

19. Running total of salaries in each department

SELECT *, 
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees1;

20. Total salary per department without GROUP BY

SELECT *, 
       SUM(Salary) OVER (PARTITION BY Department) AS TotalSalaryDept
FROM Employees1;

21. Average salary per department without GROUP BY

SELECT *, 
       AVG(Salary) OVER (PARTITION BY Department) AS AvgSalaryDept
FROM Employees1;

22. Salary minus department average

SELECT *, 
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1;

23. Moving average salary (previous, current, next)

SELECT *, 
       AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvgSalary
FROM Employees1;

24. Sum of salaries of last 3 hired employees

SELECT SUM(Salary) AS Last3HiresSalary
FROM (
    SELECT Salary
    FROM Employees1
    ORDER BY HireDate DESC
    OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
) AS Last3;


