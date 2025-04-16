--Easy Tasks
1. Combine emp_id, first_name, last_name into "100-Steven King" format:

SELECT CONCAT(emp_id, '-', first_name, ' ', last_name) AS employee_info
FROM employees;

--2. Replace '124' with '999' in phone_number:
UPDATE employees
SET phone_number = REPLACE(phone_number, '124', '999');

3. First name and length for names starting with A, J, or M:

SELECT first_name AS "First Name", LENGTH(first_name) AS "Name Length"
FROM employees
WHERE first_name LIKE 'A%' OR first_name LIKE 'J%' OR first_name LIKE 'M%'
ORDER BY first_name;

4. Total salary per manager ID:

SELECT manager_id, SUM(salary) AS total_salary
FROM employees
GROUP BY manager_id;

5. Year and highest value from Max1, Max2, Max3 per row (TestMax):

SELECT year,
       GREATEST(Max1, Max2, Max3) AS HighestValue
FROM TestMax;

6. Odd-numbered movies with non-boring description:

SELECT *
FROM cinema
WHERE MOD(id, 2) = 1 AND description != 'boring';

7. Sort by ID, with 0 last:

SELECT *
FROM SingleOrder
ORDER BY (id = 0), id;

8. First non-null value from columns (person):

SELECT COALESCE(col1, col2, col3, col4) AS first_non_null
FROM person;

9. Employees with 10–15 years of service:

SELECT employee_id, first_name, last_name, hire_date,
       ROUND(DATEDIFF(CURDATE(), hire_date)/365, 2) AS years_of_service
FROM employees
WHERE DATEDIFF(CURDATE(), hire_date)/365 BETWEEN 10 AND 15;

10. Salary greater than department average:

SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);


--Medium Tasks

1. Separate uppercase, lowercase, numbers, symbols from a string:

SELECT 
  REGEXP_REPLACE('tf56sd#%OqH', '[^A-Z]', '') AS uppercase_letters,
  REGEXP_REPLACE('tf56sd#%OqH', '[^a-z]', '') AS lowercase_letters,
  REGEXP_REPLACE('tf56sd#%OqH', '[^0-9]', '') AS numbers,
  REGEXP_REPLACE('tf56sd#%OqH', '[a-zA-Z0-9]', '') AS special_chars;

2. Split FullName into first, middle, last:

SELECT 
  SUBSTRING_INDEX(FullName, ' ', 1) AS FirstName,
  SUBSTRING_INDEX(SUBSTRING_INDEX(FullName, ' ', -2), ' ', 1) AS MiddleName,
  SUBSTRING_INDEX(FullName, ' ', -1) AS LastName
FROM Students;

3. Orders to California → same customer orders to Texas:

SELECT *
FROM Orders
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE delivery_state = 'California'
)
AND delivery_state = 'Texas';

4. Ungroup products into units: Assume table has columns: product_name, quantity

SELECT product_name
FROM Ungroup
JOIN (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
) numbers ON numbers.n <= quantity;

5. Group concatenate values (example column: value):

SELECT GROUP_CONCAT(value ORDER BY value SEPARATOR ', ') AS concatenated_values
FROM DMLTable;

6. Employment Stage by HIRE_DATE:

SELECT employee_id, first_name, hire_date,
  CASE 
    WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 1 THEN 'New Hire'
    WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) BETWEEN 1 AND 5 THEN 'Junior'
    WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) BETWEEN 6 AND 10 THEN 'Mid-Level'
    WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) BETWEEN 11 AND 20 THEN 'Senior'
    ELSE 'Veteran'
  END AS Employment_Stage
FROM employees;

7. Employees with salary > avg of their department: (Same as Easy #10 — see above)

8. Names containing 'a' and salary divisible by 5:

SELECT *
FROM employees
WHERE CONCAT(first_name, last_name) LIKE '%a%' AND salary % 5 = 0;

9. Count and percentage of employees in department with >3 years:

SELECT department_id,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN DATEDIFF(CURDATE(), hire_date) > 365*3 THEN 1 ELSE 0 END) AS employees_gt_3_years,
       ROUND(SUM(CASE WHEN DATEDIFF(CURDATE(), hire_date) > 365*3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS percentage_gt_3_years
FROM employees
GROUP BY department_id;

10. Most and least experienced Spacemen: Assuming columns: spaceman_id, hire_date, job_description

SELECT job_description,
       MAX(spaceman_id) KEEP (DENSE_RANK FIRST ORDER BY hire_date) AS Most_Experienced_ID,
       MAX(spaceman_id) KEEP (DENSE_RANK LAST ORDER BY hire_date) AS Least_Experienced_ID
FROM Personal
GROUP BY job_description;


--
1. Replace Each Row with Sum of Its Value and Previous Row's Value

Assuming the Students table has at least columns id and value:

SELECT 
  s1.id,
  s1.value + COALESCE((
      SELECT s2.value 
      FROM Students s2 
      WHERE s2.id < s1.id 
      ORDER BY s2.id DESC 
      LIMIT 1
  ), 0) AS summed_value
FROM Students s1
ORDER BY s1.id;


---

2. Determine Depth of Each Employee from the President

Using a recursive CTE (Common Table Expression):

WITH RECURSIVE EmployeeDepth AS (
  SELECT EMPLOYEE_ID, FIRST_NAME, MANAGER_ID, 0 AS depth
  FROM Employees
  WHERE MANAGER_ID = 0

  UNION ALL

  SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.MANAGER_ID, ed.depth + 1
  FROM Employees e
  JOIN EmployeeDepth ed ON e.MANAGER_ID = ed.EMPLOYEE_ID
)
SELECT EMPLOYEE_ID, FIRST_NAME, depth FROM EmployeeDepth;


---

3. Evaluate and Sum Equations from VARCHAR Column

Assuming table is named Equations and column is expression:

For databases like PostgreSQL with EXECUTE or extensions:

SELECT expression, 
       eval(expression) AS result
FROM Equations;

If no eval function exists, you may need a stored procedure or external processing (e.g., Python + SQL).


---

4. Find Students with Same Birthday

Assuming table Student has a name and birthday column:

SELECT s1.name, s1.birthday
FROM Student s1
JOIN (
  SELECT birthday 
  FROM Student 
  GROUP BY birthday 
  HAVING COUNT(*) > 1
) s2 ON s1.birthday = s2.birthday;


---

5. Aggregate Scores for Unique Player Pairs

Assuming PlayerScores table has PlayerA, PlayerB, and Score:

SELECT 
  LEAST(PlayerA, PlayerB) AS Player1,
  GREATEST(PlayerA, PlayerB) AS Player2,
  SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY LEAST(PlayerA, PlayerB), GREATEST(PlayerA, PlayerB);



