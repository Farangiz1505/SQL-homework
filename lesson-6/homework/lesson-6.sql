--Puzzle 1: Finding Distinct Values
Question: Explain at least two ways to find distinct values based on two columns.
SELECT DISTINCT LEAST(col1, col2) AS col1, GREATEST(col1, col2) AS col2 FROM InputTbl;

SELECT LEAST(col1, col2) AS col1, GREATEST(col1, col2) AS col2 FROM InputTbl GROUP BY LEAST(col1, col2), GREATEST(col1, col2);
---Puzzle 2: Removing Rows with All Zeroes
Question: If all the columns have zero values, then don’t show that row. In this case, we have to remove the 5th row while selecting data.
SELECT * FROM TestMultipleZero WHERE A <> 0 OR B <> 0 OR C <> 0 OR D <> 0;
---Puzzle 3: Find Those with Odd IDs
Question: Find those with odd ids
SELECT * FROM section1 WHERE id % 2 = 1;
---Puzzle 4: Person with the Smallest ID
Question: Person with the smallest id (use the table in puzzle 3)
SELECT * FROM section1 ORDER BY id ASC LIMIT 1;
---Puzzle 5: Person with the Highest ID
Question: Person with the highest id (use the table in puzzle 3)
SELECT * FROM section1 ORDER BY id DESC LIMIT 1;
---Puzzle 6: People Whose Name Starts with "B"
Question: People whose name starts with b (use the table in puzzle 3)
SELECT * FROM section1 WHERE name LIKE 'B%';
---Puzzle 7: Find Rows Where code Contains _ as a Literal
Question: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).
SELECT * FROM ProductCodes WHERE Code LIKE '%\_%' ESCAPE '\';
