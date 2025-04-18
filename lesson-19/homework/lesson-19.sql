1. Retrieve Employees with Salary Greater than Average Salary

SELECT * 
FROM #Employees 
WHERE Salary > (SELECT AVG(Salary) FROM #Employees);


---

2. Check if there are any employees in Department 1 using EXISTS

IF EXISTS (SELECT 1 FROM #Employees WHERE DepartmentID = 1)
    SELECT 'Employees exist in Department 1' AS Result;


---

3. Employees in the same department as Rachel Collins

SELECT * 
FROM #Employees 
WHERE DepartmentID = (
    SELECT DepartmentID 
    FROM #Employees 
    WHERE FirstName = 'Rachel' AND LastName = 'Collins'
);


---

4. Employees hired after the last hired person in Department 2

SELECT * 
FROM #Employees 
WHERE HireDate > (
    SELECT MAX(HireDate) 
    FROM #Employees 
    WHERE DepartmentID = 2
);


---

5. Employees with salary > average salary in their department

SELECT * 
FROM #Employees E
WHERE Salary > (
    SELECT AVG(Salary) 
    FROM #Employees 
    WHERE DepartmentID = E.DepartmentID
);


---

6. Count of employees per department returned with each employee

SELECT E.*, 
       (SELECT COUNT(*) 
        FROM #Employees 
        WHERE DepartmentID = E.DepartmentID) AS DeptEmployeeCount
FROM #Employees E;


---

7. Person with minimum salary

SELECT * 
FROM #Employees 
WHERE Salary = (SELECT MIN(Salary) FROM #Employees);


---

8. Employees in departments where average salary > 65000

SELECT * 
FROM #Employees 
WHERE DepartmentID IN (
    SELECT DepartmentID 
    FROM #Employees 
    GROUP BY DepartmentID 
    HAVING AVG(Salary) > 65000
);


---

9. Employees hired in the last 3 years from the last hire date

SELECT * 
FROM #Employees 
WHERE DATEDIFF(YEAR, HireDate, (SELECT MAX(HireDate) FROM #Employees)) < 3;


---

10. If anyone earns >= 80000, return all employees from that department

SELECT * 
FROM #Employees 
WHERE DepartmentID IN (
    SELECT DepartmentID 
    FROM #Employees 
    WHERE Salary >= 80000
);


---

11. Employees who earn the most in each department

SELECT * 
FROM #Employees E
WHERE Salary = (
    SELECT MAX(Salary) 
    FROM #Employees 
    WHERE DepartmentID = E.DepartmentID
);


---

12. Latest hired employee in each department

SELECT D.DepartmentName, E.FirstName, E.LastName, E.HireDate
FROM #Employees E
JOIN #Departments D ON E.DepartmentID = D.DepartmentID
WHERE E.HireDate = (
    SELECT MAX(HireDate) 
    FROM #Employees 
    WHERE DepartmentID = E.DepartmentID
);


---

13. Average salary per department per location

SELECT D.Location, D.DepartmentName, 
       AVG(E.Salary) AS AverageSalary
FROM #Employees E
JOIN #Departments D ON E.DepartmentID = D.DepartmentID
GROUP BY D.Location, D.DepartmentName;


---

14. If someone earns the average salary, return all from their department

SELECT * 
FROM #Employees 
WHERE DepartmentID IN (
    SELECT DepartmentID 
    FROM #Employees 
    GROUP BY DepartmentID 
    HAVING AVG(Salary) IN (
        SELECT Salary 
        FROM #Employees
    )
);


---

15. Departments with fewer employees than the average per department

SELECT D.*
FROM #Departments D
WHERE D.DepartmentID IN (
    SELECT DepartmentID 
    FROM #Employees 
    GROUP BY DepartmentID 
    HAVING COUNT(*) < (
        SELECT AVG(DeptCount) 
        FROM (
            SELECT COUNT(*) AS DeptCount 
            FROM #Employees 
            GROUP BY DepartmentID
        ) AS DeptStats
    )
);


---

16. Employees not in the department with the highest average salary

SELECT * 
FROM #Employees 
WHERE DepartmentID NOT IN (
    SELECT TOP 1 DepartmentID 
    FROM #Employees 
    GROUP BY DepartmentID 
    ORDER BY AVG(Salary) DESC
);


---

17. Names of departments that have employees using EXISTS

SELECT DepartmentName 
FROM #Departments D
WHERE EXISTS (
    SELECT 1 
    FROM #Employees E 
    WHERE E.DepartmentID = D.DepartmentID
);


---

18. Departments with more seniors (>=3 years) than juniors

SELECT D.*
FROM #Departments D
WHERE (
    SELECT COUNT(*) 
    FROM #Employees E 
    WHERE E.DepartmentID = D.DepartmentID 
      AND DATEDIFF(YEAR, E.HireDate, (SELECT MAX(HireDate) FROM #Employees)) > 3
) >
(
    SELECT COUNT(*) 
    FROM #Employees E 
    WHERE E.DepartmentID = D.DepartmentID 
      AND DATEDIFF(YEAR, E.HireDate, (SELECT MAX(HireDate) FROM #Employees)) < 3
);


---

19. Employees from the department with the most people

SELECT * 
FROM #Employees 
WHERE DepartmentID = (
    SELECT TOP 1 DepartmentID 
    FROM #Employees 
    GROUP BY DepartmentID 
    ORDER BY COUNT(*) DESC
);


---

20. Salary difference (max - min) in each department

SELECT DepartmentID, 
       MAX(Salary) - MIN(Salary) AS SalaryDifference
FROM #Employees
GROUP BY DepartmentID;


