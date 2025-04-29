-- Question 1: Find the average salary of employees in each department.
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department;

-- Question 2: Find the names of employees whose salary is above the average salary of all employees.
SELECT name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Question 3: List the names of departments with more than 5 employees.
SELECT department
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;

-- Question 4: Find the highest salary in each department.
SELECT department, MAX(salary) AS max_salary
FROM employees
GROUP BY department;

-- Question 5: List the name and salary of the highest-paid employee.
SELECT name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- Question 6: Find the total salary paid to employees in each department.
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- Question 7: List the names of employees who earn the minimum salary in their department.
SELECT name
FROM employees e
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
    WHERE department = e.department
);
