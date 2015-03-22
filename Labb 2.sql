use AdventureWorks;

-- Uppgift 4.0
--BACKUP DATABASE AdventureWorks
--TO DISK = 'C:\MyBackups\AW_BU.bak'

-- Uppgift 4.1
begin transaction

select @@TRANCOUNT as ActiveTransactions

select LastName
from Person.Person

update Person.Person
set LastName = 'Hult'

rollback transaction

-- Uppgift 4.2
create table dbo.TempCustomers
(
	ContactID int NULL,
	FirstName nvarchar(50) NULL,
	LastName nvarchar(50) NULL,
	City nvarchar(30) NULL,
	StateProvince nvarchar(50) NULL
)
GO

insert into dbo.TempCustomers values
(1,'Kalen','Delaney'),
(2,'Herman','Karlsson','Vislanda','Kronoberg')

insert into dbo.TempCustomers values
(3,'Tora','Eriksson','Guldsmedshyttan'),
(4,'Charlie','Carpenter','Tappström')

insert into dbo.TempCustomers(ContactID,FirstName,LastName,City) values
(3,'Tora','Eriksson','Guldsmedshyttan'),
(4,'Charlie','Carpenter','Tappström')

select ContactID
	,	FirstName
	,	LastName
	,	City
	,	StateProvince
from dbo.TempCustomers

-- Uppgift 4.3

insert into Production.Product(Name, ProductNumber, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate) values 
('Racing Gizmo', '', 1, 2, 50, 75, 1, GETDATE())

-- Uppgift 4.4
insert into dbo.TempCustomers(ContactID,FirstName,LastName,City,StateProvince) 
(
SELECT P.BusinessEntityID, P.FirstName
, P.LastName, PA.City , SP.Name
FROM Person.Person AS P
JOIN Person.BusinessEntity AS BE
ON P.BusinessEntityID=BE.BusinessEntityID
JOIN Person.BusinessEntityAddress AS BEA
ON BE.BusinessEntityID = BEA.BusinessEntityID
JOIN Person.Address PA
ON BEA.AddressID=PA.AddressID
JOIN Person.StateProvince AS SP
ON PA.StateProvinceID = SP.StateProvinceID
)

-- Uppgift 4.5
-- Töm tabellen
-- och töm buffer och cache
TRUNCATE TABLE dbo.TempCustomers
GO
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
GO
-- Lägg till data och mät tiden
DECLARE @Start DATETIME2, @Stop DATETIME2
SELECT @Start = SYSDATETIME()
INSERT INTO dbo.TempCustomers
(ContactID, FirstName, LastName)
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
SELECT @Stop = SYSDATETIME()
SELECT DATEDIFF(ms,@Start,@Stop) as MilliSeconds

-- 238ms 57ms 54ms 45ms utan index

CREATE UNIQUE CLUSTERED INDEX [Unique_Clustered]
ON [dbo].[TempCustomers]
( [ContactID] ASC )
GO
CREATE NONCLUSTERED INDEX [NonClustered_LName]
ON [dbo].[TempCustomers]
( [LastName] ASC )
GO
CREATE NONCLUSTERED INDEX [NonClustered_FName]
ON [dbo].[TempCustomers]
( [FirstName] ASC )

-- 1949ms med index 

-- Uppgift 4.6

select 
	BusinessEntityID as ContactID,
	PersonType, 
	FirstName,
	LastName,
	Title,
	EmailPromotion
into
	#TempTab
from Person.Person
where LastName IN ('Achong', 'Acevedo')

select * from #TempTab

insert into Person.Person(BusinessEntityID,PersonType,FirstName,LastName,Title,EmailPromotion)
select 
	MAX(ContactID+1),
	PersonType,
	FirstName,
	LastName,
	Title,
	EmailPromotion
from #TempTab
group by PersonType,
	FirstName,
	LastName,
	Title,
	EmailPromotion

select P.FirstName + ' ' + P.LastName as 'Name'
	,	P.BusinessEntityID as 'ContactID'
	,	P.ModifiedDate
from Person.Person as P
where P.ModifiedDate > '2015-03-11'

drop table #TempTab

-- Uppgift 4.7
update Person.Person
set FirstName = 'Gurra', Lastname = 'Tjong'
where BusinessEntityID = 292

-- Upgift 4.8
select * from Production.ProductSubcategory

update Production.Product	
set ListPrice = ListPrice * 1.1
	, ModifiedDate = GETDATE()
from Production.Product as P
	inner join Production.ProductSubcategory as PS
	on P.ProductSubcategoryID = PS.ProductSubcategoryID
	where PS.ProductSubcategoryID = 20; -- 20 == Kategorin Gloves

select Name
	, ModifiedDate
	, ListPrice	
from Production.Product
order by ModifiedDate desc


-- Uppgift 4.9
select * from dbo.TempCustomers
-- where LastName = 'Smith'


delete from dbo.TempCustomers
where LastName = 'Smith'

