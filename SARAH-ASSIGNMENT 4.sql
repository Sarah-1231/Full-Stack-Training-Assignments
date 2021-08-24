--Answer following questions
--1.	What is View? What are the benefits of using views?
-- View can be described as virtual table which derived its data from one or more than one table columns. It is stored in the database. View can be created using tables of same database or different database. It is used to implement the security mechanism in the SQL Server
--Advantages: If we need to maintain any sensitive information by providing limited access to the users, views are used for that purpose. Views are used to only display the required data to the users by keeping sensitive data safe.
--As a database view is associated with many tables upon which the view is created, it simplifies the complexity of the query.
--The view is used to hide the complexity of the underlying tables used in a database from the end-users.
--Views are useful in case of re-designing the database so as not to affect any other applications using the same database.
--The data of the computed columns can be calculated very easily when we query the data from the view, as views enable computed columns.
--2.	Can data be modified through views?
--You can't directly modify data in views based on union queries. You can't modify data in views that use GROUP BY or DISTINCT statements. All columns being modified are subject to the same restrictions as if the statements were being executed directly against the base table
--3.	What is stored procedure and what are the benefits of using it?
--A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again. So if you have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute/run it.
--You can also pass parameters to a stored procedure, so that the stored procedure can act based on the parameter value(s) that is passed.
--Stored Procedure Syntax
--CREATE PROCEDURE procedure_name
--AS
--sql_statement
--GO;
--Execute a Stored Procedure
--EXEC procedure_name
--Advantages: Better Performance –The procedure calls are quick and efficient as stored procedures are compiled once and stored in executable form.Hence the response is quick. The executable code is automatically cached, hence lowers the memory requirements.
--Higher Productivity –Since the same piece of code is used again and again so, it results in higher productivity.
--Ease of Use –To create a stored procedure, one can use any Java Integrated Development Environment (IDE). Then, they can be deployed on any tier of network architecture.
--Scalability –Stored procedures increase scalability by isolating application processing on the server.
--Maintainability –Maintaining a procedure on a server is much easier then maintaining copies on various client machines, this is because scripts are in one location.
--Security –Access to the Oracle data can be restricted by allowing users to manipulate the data only through stored procedures that execute with their definer’s privileges.
--4.	What is the difference between view and stored procedure?
--View is simple showcasing data stored in the database tables whereas a stored procedure is a group of statements that can be executed. A view is faster as it displays data from the tables referenced whereas a store procedure executes sql statements.
--5.	What is the difference between stored procedure and functions?
--The function must return a value but in Stored Procedure it is optional. Even a procedure can return zero or n values. Functions can have only input parameters for it whereas Procedures can have input or output parameters. Functions can be called from Procedure whereas Procedures cannot be called from a Function.
--6.	Can stored procedure return multiple result sets?
--Most stored procedures return multiple result sets. Such a stored procedure usually includes one or more select statements. The consumer needs to consider this inclusion to handle all the result sets
--7.	Can stored procedure be executed as part of SELECT Statement? Why?
--Store procedure cannot be used in select statement. You can re-write this SP in Function and call this function in Select statement as you need.
--A stored procedure is a module of code. It does 'something' and may or may not return anything. It may also return multiple data sets. So really you can't select from it, because it isn't an object that you can select from. You can return the results of a stored procedure into a table, and then select from that. 
--8.	What is Trigger? What types of Triggers are there?
--A trigger is a stored procedure in database which automatically invokes whenever a special event in the database occurs. For example, a trigger can be invoked when a row is inserted into a specified table or when certain table columns are being updated.
--Types of triggers: In SQL Server we can create four types of triggers Data Definition Language (DDL) triggers, Data Manipulation Language (DML) triggers, CLR triggers, and Logon triggers.
--9.	What are the scenarios to use Triggers?
--You typically use the triggers in the following scenarios:
--Log table modifications. Some tables have sensitive data such as customer email, employee salary, etc., that you want to log all the changes. ...
--Enforce complex integrity of data.
--10.	What is the difference between Trigger and Stored Procedure?
--A stored procedure is a user defined piece of code written in the local version of PL/SQL, which may return a value (making it a function) that is invoked by calling it explicitly. A trigger is a stored procedure that runs automatically when various events happen (eg update, insert, delete).
--Write queries for following scenarios
--Use Northwind database. All questions are based on assumptions described by the Database Diagram sent to you yesterday. When inserting, make up info if necessary. Write query for each step. Do not use IDE. BE CAREFUL WHEN DELETING DATA OR DROPPING TABLE.
--1.	Lock tables Region, Territories, EmployeeTerritories and Employees. Insert following information into the database. In case of an error, no changes should be made to DB.
--a.	A new region called “Middle Earth”;
begin tran
select *
from Region
select *
from Territories
select *
from Employees
select *
from EmployeeTerritories
insert into region values(5, 'Middle Earth')
if @@ERROR <>0
rollback
else begin
--b.	A new territory called “Gondor”, belongs to region “Middle Earth”;
insert into Territories values(12345, 'Gondor', 5)
declare @error int=@@error
if @error<>0
begin
print @error
rollback
end
else begin
--c.	A new employee “Aragorn King” who's territory is “Gondor”.
insert into Employees values(10, 'Aragorn', 'King', 'sales representative', 'Ms.', '1950-06-01 00:00:00.000', '1980-06-01 00:00:00.000', '123 dr', 'usa', '123-4567', '1234', null, 'graduates from columbus university', '5', 'null')
insert into EmployeeTerritories values (@@IDENTITY, 12345)
declare @error2 int = @@error
if @error <>0
begin
print @error2
rollback
end
else begin
--2.	Change territory “Gondor” to “Arnor”.
update Territories
set TerritoryDescription = 'Arnor'
where TerritoryDescription = 'Gondor'
if @@ERROR <>0
rollback
else begin
--3.	Delete Region “Middle Earth”. (tip: remove referenced data first) (Caution: do not forget WHERE or you will delete everything.) In case of an error, no changes should be made to DB. Unlock the tables mentioned in question 1.
DELETE FROM EmployeeTerritories 
WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription = 'Arnor')
DELETE FROM Territories
WHERE TerritoryDescription = 'Arnor'
DELETE FROM Region
WHERE RegionDescription = 'Middel Earth'
IF @@ERROR <>0
ROLLBACK
ELSE BEGIN
COMMIT
END
END
END
END
END
--4.	Create a view named “view_product_order_[your_last_name]”, list all products and total ordered quantity for that product.
create view view_product_order_[Qi] as
select p.ProductID, sum(od.Quantity) as totalqty
from [Order Details] od left join Products p on od.ProductID = p.ProductID
group by p.ProductID
--5.	Create a stored procedure “sp_product_order_quantity_[your_last_name]” that accept product id as an input and total quantities of order as output parameter.
create proc sp_product_order_quantity_qi 
@prodID int
as
begin
	select P.ProductID, sum(OD.Quantity) SumQty
	FROM [Order Details] OD left join Products P on OD.ProductID = P.ProductID
	where P.ProductID = @ProdID
	group by P.ProductID;
END
--6.	Create a stored procedure “sp_product_order_city_[your_last_name]” that accept product name as an input and top 5 cities that ordered most that product combined with the total quantity of that product ordered from that city as output.
create proc sp_product_order_city_qi
@prodname varchar (50)  as
BEGIN
SELECT TOP 5 ShipCity,SUM(Quantity) FROM [Order Details] OD JOIN Products P ON P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = OD.OrderID
WHERE ProductName=@ProductName
GROUP BY ProductName,ShipCity
ORDER BY SUM(Quantity) DESC
END
EXEC sp_Product_Order_City_qi
--7.	Lock tables Region, Territories, EmployeeTerritories and Employees. Create a stored procedure “sp_move_employees_[your_last_name]” that automatically find all employees in territory “Tory”; if more than 0 found, insert a new territory “Stevens Point” of region “North” to the database, and then move those employees to “Stevens Point”.
IF EXISTS(SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription ='Troy'))
BEGIN
DECLARE @TerritotyID INT
SELECT @TerritotyID = MAX(TerritoryID) FROM Territories
BEGIN TRAN
INSERT INTO Territories VALUES(@TerritotyID+1 ,'Stevens Point',3)
UPDATE EmployeeTerritories
SET TerritoryID = @TerritotyID+1
WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription ='Troy'))
IF @@ERROR <> 0
BEGIN
ROLLBACK
END
ELSE
COMMIT
END

END

EXEC sp_move_employees_qi
--8.	Create a trigger that when there are more than 100 employees in territory “Stevens Point”, move them back to Troy. (After test your code,) remove the trigger. Move those employees back to “Troy”, if any. Unlock the tables.
CREATE TRIGGER tr_move_emp_gaddam
ON EmployeeTerritories
AFTER INSERT
AS
DECLARE @EmpCount INT
SELECT @EmpCount = COUNT(*) FROM EmployeeTerritories WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription = 'Stevens Point' AND RegionID=3) GROUP BY EmployeeID
IF (@EmpCount>100)
BEGIN
UPDATE EmployeeTerritories
SET TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription ='Troy')
WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription ='Stevens Point' AND RegionID=3))
END
DROP TRIGGER tr_move_emp_gaddam

COMMIT
--9.	Create 2 new tables “people_your_last_name” “city_your_last_name”. City table has two records: {Id:1, City: Seattle}, {Id:2, City: Green Bay}. People has three records: {id:1, Name: Aaron Rodgers, City: 2}, {id:2, Name: Russell Wilson, City:1}, {Id: 3, Name: Jody Nelson, City:2}. Remove city of Seattle. If there was anyone from Seattle, put them into a new city “Madison”. Create a view “Packers_your_name” lists all people from Green Bay. If any error occurred, no changes should be made to DB. (after test) Drop both tables and view.
CREATE table city_qi (Id int not null, City varchar(20) not null)
insert into city_qi Values (1, 'Seattle')
insert into city_qi Values (2, 'Green Bay')

CREATE table people_qi (Id int not null, Name varchar(20) not null, 
City int not null)
insert into people_qi Values (1, 'Aaron Rodgers', 2)
insert into people_qi Values (2, 'Russell Wilson', 1)
insert into people_qi Values (3, 'Jody Nelson', 2)

delete from people_qi where City = 'Seattle'
insert into city_qi values (1,'Madison')

CREATE VIEW Packers_qi as
select Name from people_qi where City = 'Green Bay'

Drop table people_qi,city_qi
Drop view Packers_qi
--10.	 Create a stored procedure “sp_birthday_employees_[you_last_name]” that creates a new table “birthday_employees_your_last_name” and fill it with all employees that have a birthday on Feb. (Make a screen shot) drop the table. Employee table should not be affected.
create proc sp_birthday_employees_qi
	as 
	begin 
	SELECT * INTO #EmployeeTemp
	FROM Employees WHERE DATEPART(MM,BirthDate) = 02
	SELECT * FROM #EmployeeTemp
	END
--11.	Create a stored procedure named “sp_your_last_name_1” that returns all cites that have at least 2 customers who have bought no or only one kind of product. Create a stored procedure named “sp_your_last_name_2” that returns the same but using a different approach. (sub-query and no-sub-query).
CREATE PROC sp_qi
AS
BEGIN
SELECT City FROM CUSTOMERS
WHERE CITY IN (SELECT City FROM Customers C JOIN Orders O ON O.CustomerID=C.CustomerID JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY OD.ProductID,C.CustomerID,City
HAVING COUNT(*) BETWEEN 0 AND 1)
GROUP BY City
HAVING COUNT(*)>2
END
GO
EXEC sp_qi
GO
--12.	How do you make sure two tables have the same data?
--I would write three queries. 
--An inner join to pick up the rows where the primary key exists in both tables, but there is a difference in the value of one or more of the other columns. This would pick up changed rows in original.

--A left outer join to pick up the rows that are in the original tables, but not in the backup table (i.e. a row in original has a primary key that does not exist in backup). This would return rows inserted into the original.

--A right outer join to pick up the rows in backup which no longer exist in the original. This would return rows that have been deleted from the original.

--You could union the three queries together to return a single result set. 
--If you did this you would need to add a column to indicate what type of row it is (updated, inserted or deleted).

--With a bit of effort, you might be able to do this in one query using a full outer join. Be careful with outer joins, as they behave differently in different SQL engines. Predicates put in the where clause, instead of the join clause can sometimes turn your outer join into an inner join.
--14.
SELECT firstName+' '+lastName as 'full name'
from Person 
where middleName is null 
UNION 
SELECT firstName+' '+lastName+' '+middelName+'.' as 'full name'
from Person 
where middleName is not null
--15.
select top 1 Marks 
from MarkTable 
where Sex = 'F' 
order by Marks desc
--16.
select *
from marktable
order by sex, marks desc
