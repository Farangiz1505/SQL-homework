1. Find Employees with Minimum Salary

SELECT *
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);


---

2. Find Products Above Average Price

SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products);


---

3. Find Employees in Sales Department

SELECT *
FROM employees
WHERE department_id = (
    SELECT id FROM departments WHERE department_name = 'Sales'
);


---

4. Find Customers with No Orders

SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM orders
);


---

5. Find Products with Max Price in Each Category

SELECT *
FROM products p
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
);


---

6. Find Employees in Department with Highest Average Salary

SELECT *
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);


---

7. Find Employees Earning Above Department Average

SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);


---

8. Find Students with Highest Grade per Course

SELECT *
FROM grades g
WHERE grade = (
    SELECT MAX(grade)
    FROM grades
    WHERE course_id = g.course_id
);


---

9. Find Third-Highest Price per Category

WITH RankedProducts AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rank
    FROM products
)
SELECT *
FROM RankedProducts
WHERE rank = 3;


---

10. Find Employees Between Company Average and Department Max Salary

WITH CompanyStats AS (
    SELECT AVG(salary) AS avg_salary FROM employees
),
DeptMaxSalary AS (
    SELECT department_id, MAX(salary) AS max_salary
    FROM employees
    GROUP BY department_id
)
SELECT e.*
FROM employees e
JOIN CompanyStats cs ON 1 = 1
JOIN DeptMaxSalary dms ON e.department_id = dms.department_id
WHERE e.salary > cs.avg_salary AND e.salary < dms.max_salary;
