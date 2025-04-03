Easy
1. Definitions:
Data: Raw facts and figures that can be processed into meaningful information.
Database: A structured collection of data that allows for easy access, retrieval, and management.
Relational Database: A type of database that organizes data into tables with relationships based on keys.
Table: A structured format in a database that stores data in rows and columns.
2. Five Key Features of SQL Server:
Supports ACID transactions for data consistency.
Provides high availability and disaster recovery solutions.
Includes encryption and security features like Always Encrypted.
Allows scalability and performance tuning with indexing and partitioning.
Supports integration with BI tools like Power BI and SSIS.
3. Authentication Modes in SQL Server:
Windows Authentication: Uses Active Directory credentials to log in.
SQL Server Authentication: Uses a username and password stored in SQL Server.
Medium
1. Create a new database in SSMS:
CREATE DATABASE SchoolDB;
2. Create the Students table:
USE SchoolDB;
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);
3. Differences between SQL Server, SSMS, and SQL:
SQL Server: A relational database management system (RDBMS) used to store and manage data.
SSMS (SQL Server Management Studio): A graphical tool to interact with SQL Server, execute queries, and manage databases.
SQL (Structured Query Language): A programming language used to communicate with and manipulate databases.
Hard
1. Different SQL Commands:
DQL (Data Query Language): Retrieves data. Example:
SELECT * FROM Students;
DML (Data Manipulation Language): Modifies data. Example:
INSERT INTO Students (StudentID, Name, Age) VALUES (1, 'John Doe', 20);
DDL (Data Definition Language): Defines structure. Example:
CREATE TABLE Teachers (TeacherID INT PRIMARY KEY, Name VARCHAR(50));
DCL (Data Control Language): Manages permissions. Example:
GRANT SELECT ON Students TO User1;
TCL (Transaction Control Language): Manages transactions. Example:
BEGIN TRANSACTION;
INSERT INTO Students (StudentID, Name, Age) VALUES (2, 'Jane Doe', 22);
COMMIT;
2. Insert Three Records into the Students Table:
INSERT INTO Students (StudentID, Name, Age) VALUES 
(1, 'Alice Brown', 18), 
(2, 'Bob Smith', 19), 
(3, 'Charlie Johnson', 20);
3. Backup and Restore SchoolDB:
Backup Steps:
1. Open SSMS and connect to SQL Server.
2. Expand Databases, right-click on SchoolDB, select Tasks > Back Up.
3. Choose Full Backup and specify a destination.
4. Click OK to create the backup file.
Restore Steps:
1. Right-click on Databases, select Restore Database.
2. Choose Device, locate the backup file.
3. Select the database and click OK to restore.
