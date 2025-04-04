--EASY-LEVEL TASKS
 --DDL-DATA DEFINITION LANGUAGE.DDL is used to define, modify, and delete the structure of database objects like tables, schemas, and indexes.Main DDL commands are CREATE,ALTER,DROP AND TRUNCATE.
 --DML-DATA MANIPULATION LANGUAGE.DML is used to insert, update, delete, and retrieve data in a database. It allows users to manipulate the data stored in tables.Main commands are INSERT,UPDATE,DELETE,SELECT.
 CREATE TABLE EMPLOYEES(
 EmpID INT PRIMARY KEY,
 NAME VARCHAR(50),
 SALARY DECIMAL(10,2)
 );
 INSERT INTO Employees (EmpID, Name, Salary) VALUES  
 (1, 'JOHN', 5000.50),  
 (2, 'SARAH', 6200.75),  
 (3, 'JACK', 4500.00);
 UPDATE EMPLOYEES
 SET SALARY=5500.00
 WHERE EmpID=1
 DELETE FROM EMPLOYEES
 WHERE EmpID=2
 --Use DELETE when you need to remove specific rows but keep the table.
 --Use TRUNCATE when you need to quickly remove all rows but keep the table.
 --Use DROP when you want to permanently delete the table.
 ALTER TABLE Employees  
 ALTER COLUMN Name VARCHAR(100);
 ALTER TABLE Employees  
 ADD Department VARCHAR(50);
 The TRUNCATE TABLE command is used to quickly remove all records from a table while keeping the table structure intact.
 CREATE DATABASE COMPANYDB
 --MEDIUM-LEVEL TASKS
 CREATE TABLE Departments (  
     DeptID INT PRIMARY KEY,  
     DeptName VARCHAR(50),  
     EmpID INT,  
     FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)  
 );
 INSERT INTO Departments (DeptID, DeptName, EmpID)  
 SELECT EmpID,  
        CASE  
            WHEN EmpID = 1 THEN 'HR'  
            WHEN EmpID = 2 THEN 'Finance'  
            WHEN EmpID = 3 THEN 'IT'  
            WHEN EmpID = 4 THEN 'Marketing'  
            ELSE 'Sales'  
        END,  
        EmpID  
 FROM Employees  
 WHERE EmpID <= 5;
 UPDATE Departments  
 SET DeptName = 'Management'  
 WHERE EmpID IN (SELECT EmpID FROM Employees WHERE Salary > 5000);
 -- First, delete the related records in Departments
 DELETE FROM Departments WHERE EmpID IN (SELECT EmpID FROM Employees);
 
 -- Now, delete from Employees
 DELETE FROM Employees;
 CREATE TABLE Employees (
     EmpID INT PRIMARY KEY,
     Name VARCHAR(50),      -- Stores English or Latin characters efficiently
     Address NVARCHAR(100)  -- Supports Unicode (e.g., Chinese, Arabic, Russian)
 );
 ALTER TABLE Employees  
 ALTER COLUMN Salary FLOAT;
 ALTER TABLE Employees
 ADD JOINDATE DATE;
 ALTER TABLE Employees
 DROP COLUMN Department;
 --HARD-LEVEL TASKS
 CREATE TABLE Customers (
     CustomerID INT PRIMARY KEY,
     Name NVARCHAR(100) NOT NULL,
     Age INT CHECK (Age > 18)
 );
 DELETE FROM Employees 
 WHERE EmployeeID IN (
     SELECT EmployeeID 
     FROM SalaryHistory 
     WHERE LastIncreaseDate <= DATEADD(YEAR, -2, GETDATE())
 );CREATE PROCEDURE InsertEmployee
     @EmployeeID INT,
     @Name NVARCHAR(100),
     @Position NVARCHAR(50),
     @Salary DECIMAL(10,2),
     @HireDate DATE
 AS
 BEGIN
     INSERT INTO Employees (EmployeeID, Name, Position, Salary, HireDate)
     VALUES (@EmployeeID, @Name, @Position, @Salary, @HireDate);
 END;
 SELECT * INTO Employees_Backup
 FROM Employees
 WHERE 1 = 0;
 MERGE INTO Employees AS target
 USING NewEmployees AS source
 ON target.EmployeeID = source.EmployeeID
 WHEN MATCHED THEN 
     UPDATE SET target.Name = source.Name, 
                target.Position = source.Position, 
                target.Salary = source.Salary
 WHEN NOT MATCHED THEN 
     INSERT (EmployeeID, Name, Position, Salary) 
     VALUES (source.EmployeeID, source.Name, source.Position, source.Salary);
 	DROP DATABASE IF EXISTS CompanyDB;
 CREATE DATABASE CompanyDB;
 CREATE TABLE Departments (
     DeptID INT PRIMARY KEY
 );
 
 CREATE TABLE Employees (
     EmployeeID INT PRIMARY KEY,
     Name NVARCHAR(100),
     DeptID INT,
     FOREIGN KEY (DeptID) REFERENCES Departments(DeptID) 
     ON DELETE CASCADE ON UPDATE CASCADE
 );DBCC CHECKIDENT ('Employees', RESEED, 0);
 CREATE TABLE Products (
     ProductID INT PRIMARY KEY,
     ProductName NVARCHAR(100) UNIQUE,
     Price DECIMAL(10,2)
 );
