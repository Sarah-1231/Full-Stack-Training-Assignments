--1.    Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter. 
SELECT PRODUCTID, NAME, COLOR, LISTPRICE
FROM Production.Product
--2.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not 0 for the column ListPrice
SELECT PRODUCTID, NAME, COLOR, LISTPRICE
FROM Production.Product
WHERE ListPrice!=0
--3.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are rows that are NULL for the Color column.
SELECT PRODUCTID, NAME, COLOR, LISTPRICE
FROM Production.Product
WHERE COLOR IS NULL
--4.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.
SELECT PRODUCTID, NAME, COLOR, LISTPRICE
FROM Production.Product
WHERE COLOR IS NOT NULL
--5.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.
SELECT PRODUCTID, NAME, COLOR, LISTPRICE
FROM Production.Product
WHERE COLOR IS NOT NULL AND ListPrice>0
--6.	Generate a report that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color.
SELECT NAME + '-' + COLOR AS NAME_COLOR
FROM Production.Product
WHERE COLOR IS NOT NULL
--7.	Write a query that generates the following result set  from Production.Product:
--Name And Color
--------------------------------------------------
--NAME: LL Crankarm  --  COLOR: Black
--NAME: ML Crankarm  --  COLOR: Black
--NAME: HL Crankarm  --  COLOR: Black
--NAME: Chainring Bolts  --  COLOR: Silver
--NAME: Chainring Nut  --  COLOR: Silver
--NAME: Chainring  --  COLOR: Black
SELECT 'NAME: ' + NAME + ' -- COLOR: ' + COLOR AS 'NAME AND COLOR'
FROM Production.Product
WHERE NAME IS NOT NULL AND COLOR IS NOT NULL
--8.	Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
SELECT PRODUCTID, NAME
FROM Production.Product
WHERE ProductID BETWEEN 400 AND 500
--9.	Write a query to retrieve the to the columns  ProductID, Name and color from the Production.Product table restricted to the colors black and blue
SELECT PRODUCTID, NAME, COLOR
FROM Production.Product
WHERE COLOR IN ('BLACK', 'BLUE')
--10.	Write a query to generate a report on products that begins with the letter S. 
SELECT *
FROM Production.Product
WHERE NAME LIKE 'S%'
--11.	Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
--Name                                               ListPrice
-------------------------------------------------- -----------
--Seat Lug                                           0,00
--Seat Post                                          0,00
--Seat Stays                                         0,00
--Seat Tube                                          0,00
--Short-Sleeve Classic Jersey, L                     53,99
--Short-Sleeve Classic Jersey, M                     53,99
SELECT NAME, LISTPRICE
FROM Production.Product
WHERE NAME LIKE 'S%'
ORDER BY 1
--12.	 Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S'
 
--Name                                               ListPrice
-------------------------------------------------- ----------
--Adjustable Race                                    0,00
--All-Purpose Bike Stand                             159,00
--AWC Logo Cap                                       8,99
--Seat Lug                                           0,00
--Seat Post                                          0,00
SELECT NAME, LISTPRICE
FROM Production.Product
WHERE NAME LIKE 'A%' OR NAME LIKE 'S%'
ORDER BY 1
--13.	Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.
SELECT *
FROM Production.Product
WHERE NAME LIKE 'SPO[^K]%'
ORDER BY NAME
--14.	Write a query that retrieves unique colors from the table Production.Product. Order the results  in descending  manner
SELECT DISTINCT COLOR
FROM Production.Product
ORDER BY COLOR DESC
--15.	Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. Format and sort so the result set accordingly to the following. We do not want any rows that are NULL.in any of the two columns in the result.
SELECT ProductSubcategoryID, Color
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL AND Color IS NOT NULL
ORDER BY 1, 2
--16.	Something is “wrong” with the WHERE clause in the following query. 
--We do not want any Red or Black products from any SubCategory than those with the value of 1 in column ProductSubCategoryID, unless they cost between 1000 and 2000.
SELECT ProductSubcategoryID, LEFT([NAME], 35) AS [NAME], COLOR, ListPrice
FROM Production.Product
WHERE Color NOT IN ('RED', 'BLACK') OR ListPrice BETWEEN 1000 AND 2000 AND ProductSubcategoryID = 1
ORDER BY ProductSubcategoryID















