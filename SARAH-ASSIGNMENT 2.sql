--Answer following questions
--1.	What is a result set?
-- A result set is the output of a query. It could result in a one row, one column output or a 100+ column, million+ row output, including not only the data itself, but also metadata like column names, types and sizes.
--2.	What is the difference between Union and Union All?
--Union extracts the rows that are being specified in the query while Union All extracts all the rows including the duplicates (repeated values) from both the queries.
--3.	What are the other Set Operators SQL Server has?
--Set Operators in SQL Server (UNION, UNION ALL, INTERSECT, EXCEPT) SET operators are mainly used to combine the same type of data from two or more tables. Although more than one select statement will then be present, only one result set is returned.
--4.	What is the difference between Union and Join?
--JOIN in SQL is used to combine data from many tables based on a matched condition between them. The data combined using JOIN statement results into new columns
--UNION in SQL is used to combine the result-set of two or more SELECT statements. The data combined using UNION statement is into results into new distinct rows
--Difference between JOIN and UNION in SQL :
--JOIN combines data from many tables based on a matched condition between them； SQL combines the result-set of two or more SELECT statements
--JOIN combines data into new columns；UNION combines data into new rows
--JOIN-Number of columns selected from each table may not be same； UNION-Number of columns selected from each table should be same
--JOIN-Datatypes of corresponding columns selected from each table can be different； UNION-Datatypes of corresponding columns selected from each table should be same
--JOIN may not return distinct columns； UNION returns distinct rows
--5.	What is the difference between INNER JOIN and FULL JOIN?
--Inner join returns only the matching rows between both the tables, non-matching rows are eliminated
--Full Join returns all rows from both the tables (left & right tables), including non-matching rows from both the tables.
--6.	What is difference between left join and outer join
--Left join is actually a type of outer join. There are also right outer join and full outer join.
--Left (Outer) Join: Returns all the rows from the LEFT table and matching records between both the tables.
--Right Outer Join: Returns all the rows from the RIGHT table and matching records between both the tables.
--Full Outer Join: It combines the result of the Left Outer Join and Right Outer Join.
--7.	What is cross join?
--CROSS JOIN is used to combine all possibilities of the two or more tables and returns the result that contains every row from all contributing tables. The CROSS JOIN is also known as CARTESIAN JOIN, which provides the Cartesian product of all associated tables.
--8.	What is the difference between WHERE clause and HAVING clause?
--WHERE is used to filter rows before grouping； HAVING is used to exclude records after grouping
--WHERE clause cannot contain aggregate function like COUNT(), SUM(), MAX(), MIN(), etc； HAVING clause may contain aggregate functions
--WHERE is used to impose filtering criterion on a SELECT, UPDATE, DELETE statement as well as single row function and used before group by clause； HAVING is used to impose condition on GROUP Function and is used after GROUP BY in the query
--9.	Can there be multiple group by columns?
--A GROUP BY clause can contain two or more columns—or, in other words, a grouping can consist of two or more columns.
--Write queries for following scenarios
--1.	How many products can you find in the Production.Product table?
SELECT COUNT(PRODUCTID) AS NUM_OF_PRODUCTS
FROM PRODUCTION.PRODUCT 
--2.	Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
SELECT COUNT(PRODUCTID) AS NUM_OF_PRODUCTS
FROM PRODUCTION.PRODUCT
WHERE PRODUCTSUBCATEGORYID IS NOT NULL
--3.	How many Products reside in each SubCategory? Write a query to display the results with the following titles.
--ProductSubcategoryID CountedProducts
SELECT PRODUCTSUBCATEGORYID, COUNT(PRODUCTID) AS CountedProducts
FROM PRODUCTION.PRODUCT
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY PRODUCTSUBCATEGORYID
--4.	How many products that do not have a product subcategory. 
SELECT ProductSubcategoryID, COUNT(PRODUCTID) AS CountedProducts
FROM PRODUCTION.PRODUCT
WHERE ProductSubcategoryID IS NULL
GROUP BY ProductSubcategoryID
--5.	Write a query to list the sum of products quantity in the Production.ProductInventory table.
SELECT ProductID, COUNT(*) AS PRODUCT_QUANTITY 
FROM Production.ProductInventory
GROUP BY ProductID 
ORDER BY ProductID
--6.	 Write a query to list the sum of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.
--              ProductID    TheSum
SELECT ProductID, SUM(QUANTITY) AS THE_SUM
FROM Production.ProductInventory
WHERE LocationID=40 
GROUP BY ProductID
HAVING SUM(QUANTITY)<100
--7.	Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100
--Shelf      ProductID    TheSum
SELECT Shelf, ProductID, SUM(QUANTITY) AS TheSum
FROM Production.ProductInventory
WHERE LOCATIONID=40 AND SHELF<>'N/A'
GROUP BY ProductID, SHELF
HAVING SUM(QUANTITY)<100
--8.	Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table.
SELECT ProductID, AVG(QUANTITY) AS AVE_QUANTITY
FROM Production.ProductInventory
WHERE LocationID=10
GROUP BY ProductID
--9.	Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory
--ProductID   Shelf      TheAvg
SELECT ProductID, Shelf, AVG(QUANTITY) AS TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf
--10.	Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory
--ProductID   Shelf      TheAvg
SELECT ProductID, Shelf, AVG(QUANTITY) AS TheAvg
FROM Production.ProductInventory
WHERE SHELF <> 'N/A'
GROUP BY ProductID, Shelf
--11.	List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.
--Color           	Class 	TheCount   	 AvgPrice
SELECT COLOR, CLASS, COUNT(*) AS THECOUNT, AVG(LISTPRICE) AS AVGPRICE
FROM Production.Product
WHERE COLOR IS NOT NULL AND CLASS IS NOT NULL
GROUP BY COLOR, CLASS
--Joins:
--12.	  Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following. 
--Country                        Province
SELECT CR.Name Country,SP.Name Province 
FROM Person.CountryRegion CR 
INNER JOIN Person.StateProvince SP
ON CR.CountryRegionCode = SP.CountryRegionCode
--13.	Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.
--Country                        Province
SELECT CR.Name Country,SP.Name Province 
FROM Person.CountryRegion CR 
INNER JOIN Person.StateProvince SP 
ON CR.CountryRegionCode = SP.CountryRegionCode
WHERE CR.NAME = 'GERMANY' OR CR.NAME = 'CANADA'
--        Using Northwnd Database: (Use aliases for all the Joins)
--14.	List all Products that has been sold at least once in last 25 years.
SELECT ProductID 
FROM Orders O inner join [Order Details] OD
ON O.OrderID = OD.OrderID
WHERE OrderDate >= DATEADD(YEAR,-25,GETDATE()) AND OrderDate <= getdate()
--15.	List top 5 locations (Zip Code) where the products sold most.
SELECT top 5 ShipPostalCode,count(*) PRODUCT_AMOUNT 
FROM orders ODE 
WHERE ShipPostalCode is not Null
GROUP BY ShipPostalCode 
ORDER BY count(*) desc
--16.	List top 5 locations (Zip Code) where the products sold most in last 25 years.
SELECT top 5 ShipPostalCode,count(*) PRODUCT_AMOUNT 
FROM orders ODE 
WHERE ShipPostalCode is not Null AND ORDERDATE>='2001'
GROUP BY ShipPostalCode 
ORDER BY count(*) desc
--17.	 List all city names and number of customers in that city.     
SELECT CITY, COUNT(CUSTOMERID) COUNT_CUSTOMER
FROM CUSTOMERS
GROUP BY CITY
--18.	List city names which have more than 2 customers, and number of customers in that city 
SELECT CITY, COUNT(CUSTOMERID) COUNT_CUSTOMER
FROM CUSTOMERS
GROUP BY CITY
HAVING COUNT(CUSTOMERID)>2
--19.	List the names of customers who placed orders after 1/1/98 with order date.
SELECT ContactName, ORDERDATE
FROM ORDERS O INNER JOIN CUSTOMERS C ON O.CUSTOMERID = C.CUSTOMERID
WHERE OrderDate > '1998-01-01'
--20.	List the names of all customers with most recent order dates 
SELECT ContactName, ORDERDATE
FROM ORDERS O INNER JOIN CUSTOMERS C ON O.CUSTOMERID = C.CUSTOMERID
ORDER BY ORDERDATE DESC
--21.	Display the names of all customers  along with the  count of products they bought 
SELECT ContactName, COUNT(ORDERID) PRODUCT_COUNT
FROM ORDERS O INNER JOIN CUSTOMERS C
ON O.CUSTOMERID = C.CUSTOMERID
GROUP BY CONTACTNAME
--22.	Display the customer ids who bought more than 100 Products with count of products.
SELECT C.CustomerID, COUNT(ORDERID) PRODUCT_COUNT
FROM CUSTOMERS C INNER JOIN ORDERS O 
ON O.CUSTOMERID = C.CUSTOMERID
GROUP BY C.CustomerID
HAVING COUNT(ORDERID)>100
--23.	List all of the possible ways that suppliers can ship their products. Display the results as below
--Supplier Company Name   	Shipping Company Name
SELECT Suppliers.CompanyName [Supplier Company Name],Shippers.CompanyName [Shippers Company Name] 
FROM Suppliers cross join Shippers
--24.	Display the products order each day. Show Order date and Product Name.
SELECT OrderDate,ProductName 
FROM Orders O inner join [Order Details] OD ON O.OrderID = OD.OrderID inner join Products P ON P.ProductID = OD.ProductID
ORDER BY OrderDate DESC
--25.	Displays pairs of employees who have the same job title.
SELECT E1.LastName,E1.FirstName,E2.LastName,E2.FirstName, E1.Title 
FROM Employees E1 inner join Employees E2 ON E1.Title = E2.Title 
WHERE E1.LastName <> E2.LastName
--26.	Display all the Managers who have more than 2 employees reporting to them.
SELECT E1.LastName,E1.FirstName,E2.LastName Manager_LastName,E2.FirstName Manager_FirstName
FROM Employees E1 left join Employees E2 ON E2.EmployeeID = E1.ReportsTo
ORDER BY Manager_FirstName
--27.	Display the customers and suppliers by city. The results should have the following columns
--City Name 
--Contact Name,
--Type (Customer or Supplier)
SELECT S.City,S.ContactName,'Supplier' TypeName from Suppliers S
union all
SELECT C.City,C.ContactName,'Customer' TypeName from Customers C
--28. Have two tables T1 and T2
--F1.T1	F2.T2
--1	2
--2	3
--3	4
--Please write a query to inner join these two tables and write down the result of this query.
Select T1.id,T2.id 
FROM F1.T1 inner join F2.T2 ON T1.id = T2.id
--29. Based on above two table, Please write a query to left outer join these two tables and write down the result of this query.
Select T1.id,T2.id 
FROM F1.T1 left join F2.T2 ON T1.id = T2.id