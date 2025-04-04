EASY-LEVEL tasks 
 --1.Bulk insert-Instead of inserting rows one by one, BULK INSERT allows you to import data faster from an external file into an SQL table.
 --2.CSV,EXCEL,JSON,XML
 --3.Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
 CREATE TABLE PRODUCTS(
 ProductID int primary key,
 Productname VARCHAR(50) UNIQUE,
 Price Decimal(10,2)
 )
 --4. Insert three records into the Products table using INSERT INTO.
 INSERT INTO PRODUCTS2 VALUES(101,'LAPTOP',3000.40)
 INSERT INTO PRODUCTS2 VALUES(102,'SMARTPHONE',2000.40)
 INSERT INTO PRODUCTS2 VALUES(103,'HEADPHONES',5000.40)
 --5.Explain the difference between NULL and NOT NULL with examples.
 --NULL → Means the column can have empty (unknown) values.
 --NOT NULL → Means the column must have a value (cannot be empty).
 CREATE TABLE Employees (
     ID INT PRIMARY KEY,
     Name VARCHAR(50) NOT NULL,  -- Cannot be empty
     Email VARCHAR(100) NULL     -- Can be empty
 );
 Explanation:
 Name is NOT NULL → Every employee must have a name.
 Email is NULL → The email can be empty if the employee does not provide it.
 --6. Add a UNIQUE constraint to the ProductName column in the Products table.
 DROP TABLE PRODUCTS
 CREATE TABLE PRODUCTS2(
 ProductID int primary key,
 Productname VARCHAR(50) UNIQUE,
 --The IDENTITY column in SQL Server is used to generate auto-incrementing values for a column, typically the Primary Key. It helps ensure that each row gets a unique identifier automatically without manual input
 Price Decimal(10,2)
 )
 --7.-- The UNIQUE constraint ensures that each product name is unique,  
 -- preventing duplicate product names in the Products table.
 --8. Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
 CREATE TABLE CATEGORIES(
 CATEGORYID INT PRIMARY KEY,
 CATEGORYNAME VARCHAR(100) UNIQUE
 )
 --9.Export data from the Products table to a CSV file using SSMS.
 --took a screenshot
 --10.Explain the purpose of the IDENTITY column in SQL Server
 --The IDENTITY column in SQL Server is used to generate auto-incrementing values for a column, typically the Primary Key. It helps ensure that each row gets a unique identifier automatically without manual input.
 MEDIUM-LEVEL TASK:
 --1.Use BULK INSERT to import data from a text file into the Products table.
 BULK INSERT PRODUCTS2
 FROM 'C:\Users\HP Envy\Downloads\products2.csv'
 WITH (
     FIELDTERMINATOR =',',
     ROWTERMINATOR ='\n',
     FIRSTROW =1
   )
 select*from PRODUCTS2
 --2.Import data from an Excel file into a table called Sales using SSMS Import Wizard.
 --3.Write a query that exports the Products table data into an XML format using FOR XML.
 SELECT 
     ProductID, 
     ProductName, 
     Price
 FROM Products
 FOR XML AUTO, ELEMENTS;
 --4.Create a FOREIGN KEY in the Products table that references the Categories table
 ALTER TABLE PRODUCTS2
 ADD CONSTRAINT FK_PRODUCTS2_CATEGORIES
 FOREIGN KEY (CATEGORYID) 
 REFERENCES CATEGORIES(CATEGORYID);
 -- PRIMARY KEY: Ensures uniqueness and prevents NULLs
 --5.
 CREATE TABLE Customers (
     CustomerID INT PRIMARY KEY,
     Name VARCHAR(100) NOT NULL
 );
 
 -- UNIQUE KEY: Allows NULLs and ensures uniqueness
 CREATE TABLE Employees (
     EmployeeID INT PRIMARY KEY,
     Email VARCHAR(255) UNIQUE -- Email must be unique but can be NULL
 );
 --6.
 ALTER TABLE Products
 ADD CONSTRAINT CHK_Price CHECK (Price > 0);
 --7.SELECT * FROM Products
 FOR JSON AUTO;
 --8.
 ALTER TABLE Products
 ADD Stock INT NOT NULL DEFAULT 0;
 --9.
 SELECT ProductID, ISNULL(Price, 0) AS PriceWithDefault
 FROM Products;
 --10.CREATE TABLE Categories (
     CategoryID INT PRIMARY KEY,
     CategoryName VARCHAR(100) NOT NULL
 );
 
 CREATE TABLE Products (
     ProductID INT PRIMARY KEY,
     ProductName VARCHAR(100) NOT NULL,
     CategoryID INT,
     FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
 );
 🔴 Hard-Level Tasks (10)

   -- Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
   CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT CHECK (Age >= 18)  -- Ensures Age is at least 18
);


    --Import data from a JSON file into a table called Orders using OPENROWSET.
	-- Enable OPENROWSET usage
EXEC sp_configure 'Show Advanced Options', 1;
RECONFIGURE;
EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;

-- Import JSON data
SELECT * INTO Orders
FROM OPENROWSET(BULK 'C:\Data\Orders.json', SINGLE_CLOB) AS json_data;

   -- Create a table with an IDENTITY column starting at 100 and incrementing by 10.
   CREATE TABLE Employees (
    EmployeeID INT IDENTITY(100, 10) PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL
);

   -- Write a query that exports multiple tables into separate Excel sheets using SSMS.

    --Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
	CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, ProductID)  -- Composite Primary Key
);

   -- Explain with examples the use of COALESCE and ISNULL functions for handling NULL values.
   -- Example using COALESCE
SELECT COALESCE(NULL, 'Default Value', 'Another Value') AS Result;
-- Output: 'Default Value' (COALESCE returns the first non-null value)

-- Example using ISNULL
SELECT ISNULL(NULL, 'Fallback') AS Result;
-- Output: 'Fallback' (ISNULL replaces NULL with the second argument)

  --  Use the MERGE statement to import data from a text file into Products, updating existing records and inserting new ones.
  MERGE INTO Products AS Target
USING (
    SELECT * FROM OPENROWSET(BULK 'C:\Data\Products.txt', SINGLE_CLOB) AS src
) AS Source
ON Target.ProductID = Source.ProductID
WHEN MATCHED THEN
    UPDATE SET Target.ProductName = Source.ProductName, Target.Price = Source.Price
WHEN NOT MATCHED THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (Source.ProductID, Source.ProductName, Source.Price);

  --  Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
  CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE  -- Ensures emails are unique
);

  --  Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
  CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    ON DELETE CASCADE  -- Deletes orders when a customer is deleted
    ON UPDATE CASCADE  -- Updates orders when customer ID changes
);
