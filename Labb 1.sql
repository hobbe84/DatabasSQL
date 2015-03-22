use AdventureWorks;
       
	 /* DEL1 */
-- Uppgift 1.1
select ProductID
	, Name
	, Color
	, ListPrice
from Production.Product;

-- Uppgift 1.2
select ProductID
	, Name
	, Color
	, ListPrice 
from Production.Product
where ListPrice > 0;

-- Uppgift 1.3
select ProductID
	, Name 
	, Color
	, ListPrice 
from Production.Product
where Color is null;

-- Uppgift 1.4
select ProductID
	, Name 
	, Color
	, ListPrice 
from Production.Product
where Color is not null;

-- Uppgift 1.5
select ProductID
	, Name 
	, Color
	, ListPrice 
from Production.Product
where ListPrice > 0 
	and Color is not null;

-- Uppgift 1.6
select Name + ' ' + Color as 'Name and Color' 
from Production.Product
where Color is not null;

-- Uppgift 1.7
select 'NAME: ' + Name + ' -- ' 
	+ 'COLOR: ' +  Color as 'Name and Color'
from Production.Product
where Color is not null;

-- Uppgift 1.8
select ProductID
	, Name
from Production.Product
where ProductID between 400 and 500;

-- Uppgift 1.9
select ProductID
	, Name
	, Color 
from Production.Product
where Color in ('Black', 'Blue');

-- Uppgift 1.10
select Name
	, ListPrice
from Production.Product
where Name like 'S%';

-- Uppgift 1.11
select Name
	, ListPrice
from Production.Product
where Name like 'S%' 
	or Name like 'A%';

-- Uppgift 1.12
select Name
	, ListPrice
from Production.Product
where Name like 'SPO[^K]%'
order by Name asc;

-- Uppgift 1.13
select distinct Color
from Production.Product
where Color is not null;

-- Uppgift 1.14
select ProductSubcategoryID
	, Color
from Production.Product
where Color is not null 
	and ProductSubcategoryID is not null
order by ProductSubcategoryID asc, Color desc;

-- Uppgift 1.15
select ProductID
	, left([Name],35) as [Name]
	, Color
	, ListPrice
from Production.Product 
where Color in ('Red','Black')
	and ListPrice between 1000 and 2000
	and ProductSubcategoryID = 1
order by ProductID asc;
	
-- Uppgift 1.16
select Name
	, isnull(Color, 'Unknown') as 'Color'
	, ListPrice
from Production.Product;

      /* DEL 2 */
-- Uppgift 2.1
select count(ProductID) as 'NumberOfProducts'
from Production.Product;

-- Uppgift 2.2
select count(*) as 'NumberOfSubCategorys'
from Production.Product
where ProductSubcategoryID is not null;

-- Uppgift 2.3
select ProductSubcategoryID as 'ProductSubCategory'
	, count(*) as 'NumberOfSubProducts'	
from Production.Product
where ProductSubcategoryID is not null
group by ProductSubcategoryID;

-- Uppgift 2.4
select count(*) -
	count(ProductSubcategoryId)as 'ProductsWithoutSubCategory'	
from Production.Product 
select count(ProductID) as 'ProductswithoutSubCategory'
from Production.Product
where ProductSubcategoryID is null;

-- Uppgift 2.5
select ProductID
	, sum(Quantity) as 'NumberOfProducts'
from Production.ProductInventory
group by ProductID;

-- Uppgift 2.6
select ProductID
	, sum(Quantity) as 'NumberOfProducts'
from Production.ProductInventory
where LocationId = 40
group by ProductID, Quantity
having Quantity < 100;

-- Uppgift 2.7
select ProductID as 'ProductId'
	, Shelf as 'ShelfLocation'
	, sum(Quantity) as 'AmountOfProducts'
from Production.ProductInventory
where LocationId = 40 
group by ProductID, Quantity, Shelf
having Quantity < 100;

-- Uppgift 2.8
select LocationID as 'LocationId'
	, AVG(Quantity) as 'QuantityAverage'
from Production.ProductInventory
where LocationID = 10
group by LocationID;

-- Uppgift 2.9
select ROW_NUMBER ()
	over (order by Name) as 'RowNumber' 
	, Name as 'Category'
from Production.ProductCategory

	/* DEL 3 */
-- Uppgift 3.1
select PCR.Name as 'Country'
	, PSP.Name as 'Province'
from Person.CountryRegion as PCR
	inner join Person.StateProvince as PSP
	on PSP.CountryRegionCode = PCR.CountryRegionCode
order by PCR.Name, PSP.Name asc;

-- Uppgift 3.2
select PCR.Name as 'Country'
	, PSP.Name as 'Province'
from Person.CountryRegion as PCR
	inner join Person.StateProvince as PSP
	on PSP.CountryRegionCode = PCR.CountryRegionCode  
where PCR.Name IN ('Germany', 'Canada')
order by PCR.Name, PSP.Name asc;

-- Uppgift 3.3
select	BusinessEntityID as 'PersonID'
	, SalesPersonID as 'PersonID'
	, SalesOrderID as 'SalesOrderID'
	, OrderDate as 'Date' 
	, Bonus as 'PersonBonus'
	, SalesYTD as 'Year Total Due'
from Sales.SalesOrderHeader as SOH
	inner join Sales.SalesPerson as SP
	on SP.BusinessEntityID = SOH.SalesPersonID
order by SalesOrderID asc;

-- Uppgift 3.4
select JobTitle as 'Title'
	, OrderDate as 'Date' 
	, Bonus as 'PersonBonus'
	, SalesYTD as 'Year Total Due'
from Sales.SalesOrderHeader as SOH
	inner join Sales.SalesPerson as SP
	on SP.BusinessEntityID = SOH.SalesPersonID
	inner join HumanResources.Employee as EMP
	on EMP.BusinessEntityID = SP.BusinessEntityID
order by SalesOrderID asc;

-- Uppgift 3.5
select FirstName as 'FirstName'
	, LastName as 'LastName'
	, OrderDate as 'Date' 
	, Bonus as 'PersonBonus'
from Sales.SalesOrderHeader as SOH
	inner join Sales.SalesPerson as SP
	on SP.BusinessEntityID = SOH.SalesPersonID
	inner join HumanResources.Employee as EMP
	on EMP.BusinessEntityID = SP.BusinessEntityID
	inner join Person.Person as P
	on P.BusinessEntityID = EMP.BusinessEntityID
order by FirstName asc;

-- Uppgift 3.6
select FirstName as 'FirstName'
	, LastName as 'LastName'
	, OrderDate as 'Date' 
	, Bonus as 'PersonBonus'
from Sales.SalesOrderHeader as SOH
	inner join Sales.SalesPerson as SP
	on SP.BusinessEntityID = SOH.SalesPersonID
	inner join Person.Person as P
	on P.BusinessEntityID = SP.BusinessEntityID
order by FirstName asc;

-- Uppgift 3.7
select FirstName as 'FirstName'
	, LastName as 'LastName'
	, OrderDate as 'Date'
from Sales.SalesOrderHeader as SOH
	inner join Person.Person as P
	on P.BusinessEntityID = SOH.SalesPersonID
order by FirstName asc;

-- Uppgift 3.8
select 	SOH.OrderDate as 'Date'
	, SOH.SalesOrderID as 'OrderId'
	, P.FirstName + ' ' + P.LastName as 'SalesPerson'
	, SOD.ProductID as 'ProductID'
	, SOD.OrderQty as 'OrderQuantity'
from Sales.SalesOrderHeader as SOH
	inner join Person.Person as P
	on P.BusinessEntityID = SOH.SalesPersonID
	inner join Sales.SalesOrderDetail as SOD
	on SOD.SalesOrderID = SOH.SalesOrderID
	order by SOH.OrderDate desc, SOH.SalesOrderID ;

-- Uppgift 3.9
select 	SOH.OrderDate as 'Date'
	, SOH.SalesOrderID as 'OrderId'
	, PERS.FirstName + ' ' + PERS.LastName as 'SalesPerson'
	, PDT.Name as 'Product'
	, SOD.OrderQty as 'OrderQuantity'
from Sales.SalesOrderHeader as SOH
	inner join Person.Person as PERS
	on PERS.BusinessEntityID = SOH.SalesPersonID
	inner join Sales.SalesOrderDetail as SOD
	on SOD.SalesOrderID = SOH.SalesOrderID
	inner join Production.Product as PDT
	on PDT.ProductID = SOD.ProductID
	order by OrderDate desc, SOH.SalesOrderID ;

-- Uppgift 3.10
select 	SOH.OrderDate as 'Date'
	, SOH.SalesOrderID as 'OrderId'
	, PERS.FirstName + ' ' + PERS.LastName as 'SalesPerson'
	, PDT.Name as 'Product'
	, SOD.OrderQty as 'OrderQuantity'
from Sales.SalesOrderHeader as SOH
	inner join Person.Person as PERS
	on PERS.BusinessEntityID = SOH.SalesPersonID
	inner join Sales.SalesOrderDetail as SOD
	on SOD.SalesOrderID = SOH.SalesOrderID
	inner join Production.Product as PDT
	on PDT.ProductID = SOD.ProductID
	where SOH.OrderDate between '2004' and '2006' and SOH.SubTotal > 100000
	order by OrderDate asc, SOH.SalesOrderID ;

-- Uppgift 3.11
select PCR.Name as 'Country'
	, PSP.Name as 'Province'
from Person.CountryRegion as PCR
	full join Person.StateProvince as PSP
	on PSP.CountryRegionCode = PCR.CountryRegionCode
order by PCR.Name, PSP.Name asc;

-- Uppgift 3.12
select CUST.CustomerID as 'CustomerID'
from Sales.Customer as CUST
	full join Sales.SalesOrderHeader as SOH
	on SOH.CustomerID = CUST.CustomerID 
	where SOH.PurchaseOrderNumber is null
	order by CUST.CustomerID asc;

-- Uppgift 3.13
select P.Name as 'ProductName'
	, PM.Name as 'ProductModelName'
from Production.Product as P
	full join Production.ProductModel as PM
	on PM.ProductModelID = P.ProductModelID
	where P.Name + PM.Name is null;

-- Uppgift 3.14
select distinct SOH.SalesPersonID
	, P.FirstName + ' ' + P.LastName as 'FullName'
	, count(SOH.SalesOrderNumber) as 'NoOfOrders'
	, sum(SOH.TotalDue) as 'TotalSum'
from Sales.SalesPerson as SP
	inner join Sales.SalesOrderHeader as SOH
	on SOH.SalesPersonID = SP.BusinessEntityID
	inner join Person.Person as P
	on P.BusinessEntityID = SOH.SalesPersonID
	inner join HumanResources.Employee as EMP
	on EMP.BusinessEntityID = P.BusinessEntityID
group by SOH.SalesPersonID, P.FirstName, P.LastName;

-- Uppgift 3.15
select datepart(yyyy,SOH.OrderDate) as 'Year'
	, ST.Name as 'Region'
	, sum(SOH.SubTotal) as 'SumTotal'
from Sales.SalesOrderHeader as SOH
	inner join Sales.SalesTerritory as ST
	on ST.TerritoryID = SOH.TerritoryID
group by SOH.OrderDate, ST.Name
order by SOH.OrderDate, ST.Name asc;

-- Uppgift 3.16
select P.FirstName + ' ' + P.LastName as 'Worked At More Then One Department'
from Person.Person as P
	inner join HumanResources.Employee as EMP
	on EMP.BusinessEntityID = P.BusinessEntityID
	inner join HumanResources.EmployeeDepartmentHistory as EDH
	on EDH.BusinessEntityID = EMP.BusinessEntityID
group by P.FirstName, P.LastName
having count(EDH.EndDate) > 0
order by P.FirstName, P.LastName;

-- Uppgift 3.17
select 'Lowest SalesPrice:' as 'Value'
	, min(SOH.SubTotal) as 'Result'
from Sales.SalesOrderHeader as SOH
union
select 'Highest SalesPrice:' 
	, max(SOH.SubTotal) 
from Sales.SalesOrderHeader as SOH
union
select 'Average SalesPrice:' 
	, avg(SOH.SubTotal) 
from Sales.SalesOrderHeader as SOH
order by [Result];

-- Uppgift 3.18
select top(10) P.Name as 'Product'
	, ListPrice as 'ProductPrice'
from Production.Product as P
order by P.ListPrice desc

-- Uppgift 3.19
select top(1)percent P.Name as 'Product'
	, P.ListPrice as 'ProductPrice'
from Production.Product as P
order by P.DaysToManufacture desc


	