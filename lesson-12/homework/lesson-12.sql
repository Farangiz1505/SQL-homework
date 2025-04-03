Easy Questions

--1. What is the result of Ascii('A') in SQL?
SELECT ASCII('A') AS Result;
Result: 65
--2. Write a SQL query to get the length of the string 'Hello World' using Len().
SELECT LEN('Hello World') AS StringLength;
Result: 11
--3. How do you reverse a string 'OpenAI' using SQL?
SELECT REVERSE('OpenAI') AS ReversedString;
Result: 'IAnepO'
--4. What function would you use to add 5 spaces before a string in SQL?
SELECT SPACE(5) + 'text' AS PaddedString;
Function used: SPACE(n)
--5. How can you remove leading spaces from the string ' SQL Server'?
SELECT LTRIM(' SQL Server') AS TrimmedString;Result: 'SQL Server'
--6. Write a query that converts the string 'sql' to uppercase.
SELECT UPPER('sql') AS UppercaseString;Result: 'SQL'
--7. What function would you use to extract the first 3 characters of the string 'Database'?
SELECT LEFT('Database', 3) AS FirstThreeChars;
Result: 'Dat'
--8. How can you get the last 4 characters from the string 'Technology'?
SELECT RIGHT('Technology', 4) AS LastFourChars;
Result: 'logy'
--9. Use Substring() to get characters from position 3 to position 6 in the string 'Programming'.
SELECT SUBSTRING('Programming', 3, 4) AS ExtractedChars;
Result: 'ogra'
--10. Write a query to concatenate the strings 'SQL' and 'Server' using Concat().
SELECT CONCAT('SQL', ' ', 'Server') AS ConcatenatedString;
Result: 'SQL Server'
--11. How can you replace all occurrences of 'apple' with 'orange' in the string 'apple pie'?
SELECT REPLACE('apple pie', 'apple', 'orange') AS ReplacedString;
Result: 'orange pie'
--12. Write a query to find the position of the first occurrence of the word 'learn' in the string 'Learn SQL with LearnSQL'.
SELECT CHARINDEX('learn', 'Learn SQL with LearnSQL', 1) AS Position;
Result: 1 (case-insensitive by default)
--13. What function can you use to check if the string 'Server' contains 'er' using SQL?
SELECT CHARINDEX('er', 'Server') AS Position;
Result: 3 (if found) or 0 (if not found)
--14. How can you split the string 'apple,orange,banana' into individual words using String_split()?
SELECT value FROM STRING_SPLIT('apple,orange,banana', ',');
Result:
apple  
orange  
banana
--15. What is the result of the expression Power(2, 3)?
SELECT POWER(2, 3) AS Result;
Result: 8
--16. Write a query that calculates the square root of 16 using SQL.
SELECT SQRT(16) AS SquareRoot;
Result: 4
--17. How do you get the current date and time in SQL?
SELECT GETDATE() AS CurrentDateTime;
Returns: The current date and time based on the system's time zone.
--18. What SQL function would you use to get the current UTC date and time?
SELECT GETUTCDATE() AS CurrentUTCDateTime;
Returns: The current UTC date and time.
--19. How can you get the day of the month from the date '2025-02-03'?
SELECT DAY('2025-02-03') AS DayOfMonth;
Result: 3
--20. Write a query to add 10 days to the date '2025-02-03' using Dateadd().
SELECT DATEADD(DAY, 10, '2025-02-03') AS NewDate;
Result: '2025-02-13'
Here are the solutions to the Medium Questions in SQL.
Medium Questions
--21. Write a SQL query to extract the year from the date '2025-12-25'.
SELECT YEAR('2025-12-25'); -- Result: 2025
--22. How can you find the difference in days between '2025-12-25' and '2025-12-01'?
SELECT DATEDIFF(DAY, '2025-12-01', '2025-12-25'); -- Result: 24
--23. What function would you use to return the first non-null value among NULL, 'SQL', and 'Database'?
SELECT COALESCE(NULL, 'SQL', 'Database'); -- Result: 'SQL'
--24. Write a query to count the number of rows in a table named Employees.
SELECT COUNT(*) FROM Employees;
--25. How do you get the number of distinct job titles from the Employees table?
SELECT COUNT(DISTINCT JobTitle) FROM Employees;
--26. Write a query to get the maximum salary from the Employees table.
SELECT MAX(Salary) FROM Employees;
--27. How can you get the average salary of employees in the Employees table?
SELECT AVG(Salary) FROM Employees;
--28. Write a query to find the employee(s) with the highest salary in the Employees table.
SELECT * FROM Employees WHERE Salary = (SELECT MAX(Salary) FROM Employees);
--29. How do you group employees by Department and count the number of employees in each department?
SELECT Department, COUNT(*) AS EmployeeCount FROM Employees GROUP BY Department;
--30. Write a query to get the top 3 highest-paid employees from the Employees table.
SELECT TOP 3 * FROM Employees ORDER BY Salary DESC;
--31. How can you filter employees with a salary greater than 50,000?
SELECT * FROM Employees WHERE Salary > 50000;
--32. Write a query to get employees whose names start with 'J'.
SELECT * FROM Employees WHERE Name LIKE 'J%';
--33. How do you find employees whose names contain 'an'?
SELECT * FROM Employees WHERE Name LIKE '%an%';
--34. Write a query to retrieve employees who joined between '2022-01-01' and '2023-01-01'.
SELECT * FROM Employees WHERE JoinDate BETWEEN '2022-01-01' AND '2023-01-01';
--35. How can you get all employees who do not have a manager assigned (ManagerID is NULL)?
SELECT * FROM Employees WHERE ManagerID IS NULL;
--36. Write a query to find employees who have a salary between 40,000 and 60,000.
SELECT * FROM Employees WHERE Salary BETWEEN 40000 AND 60000;
--37. How can you retrieve employees who have either 'Developer' or 'Manager' as their job title?
SELECT * FROM Employees WHERE JobTitle IN ('Developer', 'Manager');
--38. Write a query to retrieve all employees, sorting by Department in ascending order and Salary in descending order.
SELECT * FROM Employees ORDER BY Department ASC, Salary DESC;
--39. How do you update the salary of all employees in the 'IT' department by 10%?
UPDATE Employees SET Salary = Salary * 1.10 WHERE Department = 'IT';
--40. Write a query to delete all employees who have left the company (EmploymentStatus = 'Terminated').
DELETE FROM Employees WHERE EmploymentStatus = 'Terminated';
Hard Questions
--41. Write a query to retrieve the second highest salary from the Employees table.
SELECT MAX(Salary) AS SecondHighestSalary 
FROM Employees 
WHERE Salary < (SELECT MAX(Salary) FROM Employees);
--42. How can you get the third highest salary using a subquery?
SELECT MAX(Salary) AS ThirdHighestSalary 
FROM Employees 
WHERE Salary < (SELECT MAX(Salary) FROM Employees WHERE Salary < (SELECT MAX(Salary) FROM Employees));
--43. Retrieve the department with the highest number of employees.
SELECT Department 
FROM Employees 
GROUP BY Department 
ORDER BY COUNT(*) DESC 
LIMIT 1;
--44. Write a query to get the employees who earn more than the average salary.
SELECT * 
FROM Employees 
WHERE Salary > (SELECT AVG(Salary) FROM Employees);
--45. How do you retrieve employees who have the same salary as someone else?
SELECT * 
FROM Employees e1 
WHERE EXISTS (
    SELECT 1 FROM Employees e2 
    WHERE e1.Salary = e2.Salary AND e1.ID <> e2.ID
);
--46. Write a query to find employees who have the same JobTitle as at least one other employee.
SELECT * 
FROM Employees e1 
WHERE EXISTS (
    SELECT 1 FROM Employees e2 
    WHERE e1.JobTitle = e2.JobTitle AND e1.ID <> e2.ID
);
--47. Retrieve the employees who have been working for the longest time in the company.
SELECT * 
FROM Employees 
WHERE JoinDate = (SELECT MIN(JoinDate) FROM Employees);
--48. Write a query to list all employees along with their manager's name.
SELECT e1.Name AS Employee, e2.Name AS Manager 
FROM Employees e1 
LEFT JOIN Employees e2 
ON e1.ManagerID = e2.ID;
--49. Find the department with the highest average salary.
SELECT Department 
FROM Employees 
GROUP BY Department 
ORDER BY AVG(Salary) DESC 
LIMIT 1;
--50. Write a query to find the cumulative salary sum of employees ordered by salary.
SELECT Name, Salary, 
       SUM(Salary) OVER (ORDER BY Salary) AS CumulativeSalary 
FROM Employees;
--51. How can you rank employees by salary within their department?
SELECT Name, Department, Salary, 
       RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS Rank 
FROM Employees;
--52. Retrieve the employees who have a higher salary than their manager.
SELECT e1.* 
FROM Employees e1 
JOIN Employees e2 
ON e1.ManagerID = e2.ID 
WHERE e1.Salary > e2.Salary;
--53. Find the department with the maximum total salary expense.
SELECT Department 
FROM Employees 
GROUP BY Department 
ORDER BY SUM(Salary) DESC 
LIMIT 1;
--54. Write a query to get employees whose salary is in the top 10% of all salaries.
SELECT * 
FROM Employees 
WHERE Salary >= (SELECT PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Salary) FROM Employees);
--55. Retrieve employees who are in the same department as 'John Doe'.
SELECT * 
FROM Employees 
WHERE Department = (SELECT Department FROM Employees WHERE Name = 'John Doe');
--56. Find the difference between the highest and lowest salaries in each department.
SELECT Department, 
       MAX(Salary) - MIN(Salary) AS SalaryDifference 
FROM Employees 
GROUP BY Department;
--57. Write a query to return the department with the largest salary gap between employees.
SELECT Department 
FROM Employees 
GROUP BY Department 
ORDER BY (MAX(Salary) - MIN(Salary)) DESC 
LIMIT 1;
--58. Retrieve employees who have joined within the last 6 months.
SELECT * 
FROM Employees 
WHERE JoinDate >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
59. Find employees who have changed departments at least once.
SELECT EmployeeID 
FROM EmployeeHistory 
GROUP BY EmployeeID 
HAVING COUNT(DISTINCT Department) > 1;
--60. Write a query to get employees with a salary greater than the department's average salary.
SELECT * 
FROM Employees e1 
WHERE Salary > (SELECT AVG(Salary) FROM Employees e2 WHERE e1.Department = e2.Department);
