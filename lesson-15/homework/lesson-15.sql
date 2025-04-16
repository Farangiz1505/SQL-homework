Easy tasks
1. Matching and Non-Matching Items:

Question:
Given two tables Cart1 and Cart2, write an SQL query to show matching and non-matching items side by side.

Answer:

SELECT 
    c1.item_id, 
    c1.item_name AS cart1_item, 
    c2.item_name AS cart2_item
FROM 
    Cart1 c1
LEFT JOIN 
    Cart2 c2 ON c1.item_id = c2.item_id
UNION
SELECT 
    c2.item_id, 
    c1.item_name AS cart1_item, 
    c2.item_name AS cart2_item
FROM 
    Cart2 c2
LEFT JOIN 
    Cart1 c1 ON c2.item_id = c1.item_id;


---

2. Average Days Between Executions:

Question:
Write an SQL statement to determine the average number of days between executions for each workflow from the ProcessLog table.

Answer:

SELECT 
    workflow_id, 
    AVG(DATEDIFF(execution_date, previous_execution_date)) AS avg_days_between_executions
FROM 
    (SELECT 
        workflow_id, 
        execution_date, 
        LEAD(execution_date) OVER (PARTITION BY workflow_id ORDER BY execution_date) AS previous_execution_date
    FROM 
        ProcessLog) AS subquery
GROUP BY 
    workflow_id;


---

3. Movie Details with Specific Actors:

Question:
Write a query to get the movie details where Mr. Amitabh and Mr. Vinod acted together, and their role is "actor."

Answer:

SELECT 
    m.movie_id, 
    m.movie_title, 
    a.actor_name, 
    r.role
FROM 
    Movies m
JOIN 
    Cast c ON m.movie_id = c.movie_id
JOIN 
    Actors a ON c.actor_id = a.actor_id
JOIN 
    Roles r ON c.role_id = r.role_id
WHERE 
    a.actor_name IN ('Amitabh', 'Vinod') AND 
    r.role = 'actor'
GROUP BY 
    m.movie_id
HAVING 
    COUNT(DISTINCT a.actor_name) = 2;


---

4. Pivoting Customer Phone Numbers:

Question:
Write an SQL query to pivot the data so that each customer's phone numbers appear in separate columns from the PhoneDirectory table.

Answer:

SELECT 
    customer_id, 
    MAX(CASE WHEN phone_type = 'Home' THEN phone_number END) AS home_phone,
    MAX(CASE WHEN phone_type = 'Work' THEN phone_number END) AS work_phone,
    MAX(CASE WHEN phone_type = 'Mobile' THEN phone_number END) AS mobile_phone
FROM 
    PhoneDirectory
GROUP BY 
    customer_id;


---

5. Numbers Divisible by 9:

Question:
Write an SQL query to find all numbers up to a given number n that are divisible by 9.

Answer:

SELECT number 
FROM Numbers 
WHERE number % 9 = 0 AND number <= n;


---

6. Batch Starts and Ends:

Question:
Write an SQL query to return each batch with its corresponding start line and the line where it ends (i.e., the line containing "GO") from BatchStarts and BatchLines tables.

Answer:

SELECT 
    bs.batch_id,
    MIN(bl.line_number) AS start_line,
    MAX(bl.line_number) AS end_line
FROM 
    BatchStarts bs
JOIN 
    BatchLines bl ON bs.batch_id = bl.batch_id
WHERE 
    bl.line_text LIKE '%GO%'
GROUP BY 
    bs.batch_id;


---

7. Running Balance of Inventory:

Question:
Write an SQL statement that will provide a running balance of the inventory from the Inventory table.

Answer:

SELECT 
    transaction_date, 
    product_id, 
    SUM(quantity) OVER (PARTITION BY product_id ORDER BY transaction_date) AS running_balance
FROM 
    Inventory;


---

8. Nth Highest Salary:

Question:
Write a query to find the Nth highest salary from the table (e.g., 2nd highest salary).

Answer:

SELECT 
    DISTINCT salary 
FROM 
    Employees
ORDER BY 
    salary DESC
LIMIT 1 OFFSET (N-1);


---

9. Current and Previous Year’s Sales:

Question:
Write an SQL statement that shows the current year’s sales, along with the previous year’s sales, and the sales from two years ago from the Sales table.

Answer:

SELECT 
    YEAR(sale_date) AS year,
    SUM(sale_amount) AS total_sales
FROM 
    Sales
WHERE 
    YEAR(sale_date) IN (YEAR(CURDATE()), YEAR(CURDATE())-1, YEAR(CURDATE())-2)
GROUP BY 
    YEAR(sale_date)
ORDER BY 
    year DESC;


---

10. Boxes with Same Dimensions:

Question:
Write an SQL statement to determine which boxes have the same dimensions from the Boxes table.

Answer:

SELECT 
    box_id, 
    length, 
    width, 
    height
FROM 
    Boxes
GROUP BY 
    length, width, height
HAVING 
    COUNT(*) > 1;


---

11. Numbers Table with Doubling and Adding 1:

Question:
Create a numbers table where you start with the number 1, then double the number if the result is less than 100, else add 1.

Answer:

WITH RECURSIVE NumberSequence AS (
    SELECT 1 AS number
    UNION ALL
    SELECT 
        CASE 
            WHEN number * 2 < 100 THEN number * 2
            ELSE number + 1
        END
    FROM 
        NumberSequence
    WHERE 
        number < 100
)
SELECT number FROM NumberSequence;


---

12. Unique Status Count for Workflows:

Question:
For each record in the WorkflowSteps table, determine the number of unique statuses that occurred prior to and including the current status.

Answer:

SELECT 
    workflow_id, 
    step_id, 
    COUNT(DISTINCT status) AS unique_status_count
FROM 
    WorkflowSteps
WHERE 
    step_id <= (SELECT MAX(step_id) FROM WorkflowSteps WHERE workflow_id = ws.workflow_id)
GROUP BY 
    workflow_id, 
    step_id;


---

13. Alternate Male and Female:

Question:
In the AlternateMaleFemale table, print male and female alternate entries.

Answer:

SELECT 
    CASE 
        WHEN MOD(ROW_NUMBER() OVER (ORDER BY id), 2) = 0 THEN 'Female'
        ELSE 'Male'
    END AS gender
FROM 
    AlternateMaleFemale;


---

14. Consecutive Status Grouping:

Question:
Write a query which will group consecutive rows with the same status from the Groupings table and return the min and max step numbers, the status, and the count of consecutive steps.

Answer:

WITH ConsecutiveGroups AS (
    SELECT 
        status, 
        step_number,
        ROW_NUMBER() OVER (PARTITION BY status ORDER BY step_number) - ROW_NUMBER() OVER (ORDER BY step_number) AS group_id
    FROM 
        Groupings
)
SELECT 
    MIN(step_number) AS min_step, 
    MAX(step_number) AS max_step, 
    status, 
    COUNT(*) AS consecutive_count
FROM 
    ConsecutiveGroups
GROUP BY 
    group_id, status;


---

15. Permutations of 0 and 1:

Question:
Create a result set of all permutations for the combination of 0 and 1 with a length of n digits.

Answer:

WITH RECURSIVE Permutations AS (
    SELECT '0' AS perm
    UNION ALL
    SELECT '1' AS perm
    FROM Permutations
    WHERE LENGTH(perm) < n
)
SELECT perm FROM Permutations;
Sure, let's continue with the SQL questions and answers.


---

16. Employees with Highest Salary:

Question:
Write an SQL query to find the employees who earn the highest salary.

Answer:

SELECT 
    employee_id, 
    employee_name, 
    salary
FROM 
    Employees
WHERE 
    salary = (SELECT MAX(salary) FROM Employees);


---

17. Find Departments with More Than 10 Employees:

Question:
Write a query to find departments with more than 10 employees.

Answer:

SELECT 
    department_id, 
    COUNT(*) AS employee_count
FROM 
    Employees
GROUP BY 
    department_id
HAVING 
    COUNT(*) > 10;


---

18. Employees with Missing Phone Numbers:

Question:
Write an SQL query to find employees who don't have a phone number listed.

Answer:

SELECT 
    employee_id, 
    employee_name
FROM 
    Employees
WHERE 
    phone_number IS NULL;


---

19. Top N Earning Employees:

Question:
Write a query to find the top N earning employees, where N is given as an input (for example, top 5 earning employees).

Answer:

SELECT 
    employee_id, 
    employee_name, 
    salary
FROM 
    Employees
ORDER BY 
    salary DESC
LIMIT N;


---

20. Check for Duplicate Emails:

Question:
Write an SQL query to find duplicate email addresses in the Customers table.

Answer:

SELECT 
    email, 
    COUNT(*) AS email_count
FROM 
    Customers
GROUP BY 
    email
HAVING 
    COUNT(*) > 1;


---

21. Join Two Tables and Calculate Total Sales:

Question:
Write a query to join the Orders and OrderDetails tables and calculate the total sales for each order.

Answer:

SELECT 
    o.order_id, 
    SUM(od.quantity * od.unit_price) AS total_sales
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.order_id = od.order_id
GROUP BY 
    o.order_id;


---

22. Employees in Same Department as 'John Doe':

Question:
Write an SQL query to find all employees who work in the same department as "John Doe".

Answer:

SELECT 
    e.employee_id, 
    e.employee_name
FROM 
    Employees e
WHERE 
    e.department_id = (SELECT department_id FROM Employees WHERE employee_name = 'John Doe');


---

23. Find Employees with More Than One Job:

Question:
Write a query to find employees who have more than one job title in the EmployeeJobs table.

Answer:

SELECT 
    employee_id, 
    COUNT(DISTINCT job_title) AS job_count
FROM 
    EmployeeJobs
GROUP BY 
    employee_id
HAVING 
    COUNT(DISTINCT job_title) > 1;


---

24. Calculate Age from Birthdate:

Question:
Write a query to calculate the age of employees based on their birthdate.

Answer:

SELECT 
    employee_id, 
    employee_name, 
    TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS age
FROM 
    Employees;


---

25. Count Products in Each Category:

Question:
Write an SQL query to count the number of products in each category from the Products table.

Answer:

SELECT 
    category_id, 
    COUNT(*) AS product_count
FROM 
    Products
GROUP BY 
    category_id;


---

26. Sales in the Last 30 Days:

Question:
Write a query to calculate the total sales in the last 30 days.

Answer:

SELECT 
    SUM(sale_amount) AS total_sales
FROM 
    Sales
WHERE 
    sale_date >= CURDATE() - INTERVAL 30 DAY;


---

27. Get Employees and Their Manager's Details:

Question:
Write an SQL query to retrieve employee details along with their manager's details, assuming a self-join on the Employees table.

Answer:

SELECT 
    e.employee_id AS employee_id,
    e.employee_name AS employee_name,
    m.employee_id AS manager_id,
    m.employee_name AS manager_name
FROM 
    Employees e
LEFT JOIN 
    Employees m ON e.manager_id = m.employee_id;


---

28. Customers Who Ordered More Than One Product:

Question:
Write an SQL query to find customers who ordered more than one product.

Answer:

SELECT 
    customer_id, 
    COUNT(DISTINCT product_id) AS product_count
FROM 
    Orders
GROUP BY 
    customer_id
HAVING 
    COUNT(DISTINCT product_id) > 1;


---

29. Top Selling Products by Category:

Question:
Write a query to find the top-selling product in each category from the OrderDetails table.

Answer:

SELECT 
    p.category_id, 
    p.product_name, 
    SUM(od.quantity) AS total_sales
FROM 
    OrderDetails od
JOIN 
    Products p ON od.product_id = p.product_id
GROUP BY 
    p.category_id, p.product_name
ORDER BY 
    p.category_id, total_sales DESC;


---

30. Find Products Not Ordered:

Question:
Write an SQL query to find all products that have not been ordered.

Answer:

SELECT 
    p.product_id, 
    p.product_name
FROM 
    Products p
LEFT JOIN 
    OrderDetails od ON p.product_id = od.product_id
WHERE 
    od.product_id IS NULL;


---

31. Count Orders by Day:

Question:
Write a query to count the number of orders placed each day.

Answer:

SELECT 
    order_date, 
    COUNT(*) AS order_count
FROM 
    Orders
GROUP BY 
    order_date
ORDER BY 
    order_date;


---

32. Products With Stock Below Threshold:

Question:
Write an SQL query to find products where the stock level is below the minimum threshold.

Answer:

SELECT 
    product_id, 
    product_name, 
    stock_level
FROM 
    Products
WHERE 
    stock_level < min_stock_level;


---

33. Average Sales Per Employee:

Question:
Write an SQL query to find the average sales amount per employee.

Answer:

SELECT 
    e.employee_id, 
    e.employee_name, 
    AVG(od.quantity * od.unit_price) AS avg_sales
FROM 
    Employees e
JOIN 
    Orders o ON e.employee_id = o.employee_id
JOIN 
    OrderDetails od ON o.order_id = od.order_id
GROUP BY 
    e.employee_id;


---

34. Employees Who Have Never Made a Sale:

Question:
Write a query to find employees who have never made a sale.

Answer:

SELECT 
    e.employee_id, 
    e.employee_name
FROM 
    Employees e
LEFT JOIN 
    Orders o ON e.employee_id = o.employee_id
WHERE 
    o.order_id IS NULL;


---

35. Find Customers with the Most Orders:

Question:
Write an SQL query to find customers who have placed the most orders.

Answer:

SELECT 
    customer_id, 
    COUNT(*) AS order_count
FROM 
    Orders
GROUP BY 
    customer_id
ORDER BY 
    order_count DESC
LIMIT 1;


---

36. Find Orders with Multiple Products:

Question:
Write a query to find orders that contain more than one product.

Answer:

SELECT 
    order_id, 
    COUNT(DISTINCT product_id) AS product_count
FROM 
    OrderDetails
GROUP BY 
    order_id
HAVING 
    COUNT(DISTINCT product_id) > 1;


---

37. Average Product Price by Category:

Question:
Write an SQL query to find the average price of products in each category.

Answer:

SELECT 
    category_id, 
    AVG(price) AS average_price
FROM 
    Products
GROUP BY 
    category_id;
