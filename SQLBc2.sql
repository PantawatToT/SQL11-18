--Student ID 67040249125
--Student Name Pantawat naree

-- *********แบบฝึกหัด Basic Query #2 ***************
 
 --1. จงแสดงรหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย เฉพาะสินค้าประเภท Seafood
 --แบบ Product
select ProductID, ProductName, UnitPrice
from Categories As C , Products As P
where C.categoryID = P.CategoryID AND CategoryName = 'Seafood'

--แบบ Join
select ProductID, ProductName, UnitPrice
from Categories As C INNER JOIN Products AS p ON C.CategoryID = P.CategoryID
where CATEgoryName = 'Seafood';

---------------------------------------------------------------------
--2.จงแสดงชื่อบริษัทลูกค้า ประเทศที่ลูกค้าอยู่ และจำนวนใบสั่งซื้อที่ลูกค้านั้น ๆ ที่รายการสั่งซื้อในปี 1997
--แบบ Product
select CompanyName, Country, COUNT(OrderID) AS Numorders
from Customers As Cu, Orders As O
where Cu.CustomerID = O.CustomerID
	And YEAR(OrderDate) = 1997
Group By CompanyName, Country;

--แบบ Join
select CompanyName, Country, Count(OrderID) As NumOrders
from Customers AS Cu INNER Join Orders AS O ON Cu.CustomerID = O.CustomerID
where YEAR(Orderdate) = 1997
Group By CompanyName, Country;

---------------------------------------------------------------------
--3. จงแสดงรหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย ชื่อบริษัทและประเทศที่จัดจำหน่ายสินค้านั้น ๆ
--แบบ Product
select ProductID, ProductName, UnitPrice, CompanyName
from Products As P , Suppliers AS S
where P.SupplierID = S.SupplierID;

--แบบ Join
select ProductID, ProductName, UnitPrice, CompanyName
from Products As P INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID;


---------------------------------------------------------------------
--4. ชื่อ-นามสกุลของพนักงานขาย ตำแหน่งงาน และจำนวนใบสั่งซื้อที่แต่ละคนเป็นผู้ทำรายการขาย 
--เฉพาะที่ทำรายการขายช่วงเดือนมกราคม-เมษายน ปี 1997 และแสดงเฉพาะพนักงานที่ทำรายการขายมากกว่า 10 ใบสั่งซื้อ 
--แบบ Product
select FirstName+SPACE(3)+LastName AS EmployeeName, Title,
	   COUNT(OrderID) AS NumOrders
from Employees As E , Orders AS O
where E.EmployeeID = O.EmployeeID
	  And OrderDate Between '1997-01-01' AND '1997-04-30'
Group by Firstname, LastName, Title
Having COUNT(OrderID) > 10;
--แบบ Join
select FirstName+SPACE(3)+LastName AS EmployeeName, Title,
		COUNT(OrderID) AS Numorders
from Employees as E INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
where Orderdate BETWEEN '1997-01-01' AND '1997-04-30'
Group by FirstName, LastName, Title
Having COUNT(OrderID) > 10;

---------------------------------------------------------------------
--5.จงแสดงรหัสสินค้า ชื่อสินค้า ยอดขายรวม(ไม่คิดส่วนลด) ของสินค้าแต่ละชนิด
--แบบ Product
select P.ProductID, ProductName, SUM(OD.UnitPrice * Quantity) AS SumPrice
From [Order Details] As OD , Products AS P
where OD.ProductID = P.ProductID
Group By P.ProductID, ProductName
Order By ProductID ASC
--แบบ Join
select P.ProductID, ProductName, SUM(OD.UnitPrice * Quantity) AS SumPrice
From [Order Details] As OD INNER JOIN Products AS P ON OD.ProductID = P.ProductID
where OD.ProductID = P.ProductID
Group By P.ProductID, ProductName
Order By ProductID ASC

---------------------------------------------------------------------
/*6.จงแสดงรหัสบริษัทจัดส่ง ชื่อบริษัทจัดส่ง จำนวนใบสั่งซื้อที่จัดส่งไปยังประเทศสหรัฐอเมริกา, 
อิตาลี, สหราชอาณาจักร, แคนาดา ในเดือนมกราคม-สิงหาคม ปี 1997 */
--แบบ Product
select ShipperID, CompanyName, COUNT(OrderID) AS NumShipoedOrder
from Orders AS O , shippers AS S
where O.ShipVia = S.ShipperID
		AND ShipCountry IN ('USA', 'Italy', 'UK', 'Canada')
		AND ShippedDate BETWEEN '1997-01-01' AND '1997-08-31'
Group by shipperID, CompanyName;
--แบบ Join
select ShipperID, CompanyName, COUNT(OrderID) AS NumShipoedOrder
from Orders AS O INNER JOIN shippers AS S ON O.ShipVia = S.ShipperID
where ShipCountry IN ('USA', 'Italy', 'UK', 'Canada')
	  AND ShippedDate BETWEEN '1997-01-01' AND '1997-08-31'
Group by shipperID, CompanyName;


---------------------------------------------------------------------
-- *** 3 ตาราง ****
/*7 : จงแสดงเลขเดือน ยอดสั่งซื้อรวม(ไม่คิดส่วนลด) เฉพาะรายการสั่งซื้อที่ทำรายการขายในปี 1996 
และจัดส่งไปยังประเทศสหราชอาณาจักร,เบลเยี่ยม, โปรตุเกส, ของพนักงานขายชื่อ Nancy Davolio*/
--แบบ Product
select *
from Orders As O, [Order Details] as OD, Employees as E
where O.OrderID = OD.OrderID AND O.EmployeeID = E.EmployeeID
	  AND YEAR(OrderDate) = 1996
	  AND ShipCountry IN ('UK', 'Belgium','Portugal')
	  AND FirstName = 'Nancy Davolio' AND LastName = 'Davolio'
Group by Count(OrderDate)
--แบบ Join
select *
from Orders as O INNER JOIN [Order Details] As OD ON O.OrderID = OD.OrderID
				 INNER JOIN Employees AS E ON O.EmployeeID = E.EmployeeID
where YEAR(OrderDate) = 1996
	  AND ShipCountry IN ('UK', 'Belgium','Portugal')
	  AND FirstName = 'Nancy Davolio' AND LastName = 'Davolio'
Group by Count(OrderDate)

--------------------------------------------------------------------------------

/*8 : จงแสดงข้อมูลรหัสลูกค้า ชื่อบริษัทลูกค้า และยอดรวม(ไม่คิดส่วนลด) เฉพาะใบสั่งซื้อที่ทำรายการสั่งซื้อในเดือน มค. ปี 1997 
จัดเรียงข้อมูลตามยอดสั่งซื้อมากไปหาน้อย*/
--แบบ Product
select C.CustomerID, CompanyName, Sum(UnitPrice * Quantity) As Sumprice
from [Order Details] AS OD, orders AS O, Customers as C
where OD.OrderID = O.OrderID AND O.CustomerID = C.CustomerID
	  And OrderDate between '1997-01-01' And '1997-01-31'
Group by C.CustomerID, CompanyName
order by SumPrice DESC

--แบบ Join
select C.CustomerID, CompanyName, Sum(UnitPrice * Quantity) As Sumprice
from [Order Details] AS OD INNER JOIN orders AS O ON OD.OrderID = O.OrderID
						   INNER JOIN Customers AS C on O.CustomerID = C.CustomerID
where OD.OrderID = O.OrderID AND O.CustomerID = C.CustomerID

---------------------------------------------------------------------------------

/*9 : จงแสดงรหัสผู้จัดส่ง ชื่อบริษัทผู้จัดส่ง ยอดรวมค่าจัดส่ง เฉพาะรายการสั่งซื้อที่ Nancy Davolio เป็นผู้ทำรายการขาย*/
--แบบ Product
select ShipperID, CompanyName, Sum(Freight) AS Sum_Freight
from Shippers AS S, Orders As O, Employees AS E
where S.ShipperID = O.ShipVia AND E.EmployeeID = O.EmployeeID
	 AND FirstName = 'Nancy' AND LastName = 'Davolio'
Group by ShipperID, CompanyName;

--แบบ Join
select ShipperID, CompanyName, Sum(Freight) AS Sum_Freight
from Employees as E INNER JOIN Orders As O ON E.EmployeeID = O.EmployeeID
					INNER JOIN Shippers As S ON O.ShipVia = S.ShipperID
where FirstName = 'Nancy' AND LastName = 'Davolio'
Group by ShipperID, CompanyName;

---------------------------------------------------------------------------------
/*10 : จงแสดงข้อมูลรหัสใบสั่งซื้อ วันที่สั่งซื้อ รหัสลูกค้าที่สั่งซื้อ ประเทศที่จัดส่ง จำนวนที่สั่งซื้อทั้งหมด ของสินค้าชื่อ Tofu ในช่วงปี 1997*/
--แบบ Product
select O.OrderID, OrderDate, CustomerID, ShipCountry, Quantity
from [Order Details] As OD, Orders As O, Products As P
where O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID
	  And ProductName = 'Tofu'
	  And YEAR(OrderDate) = 1997
Order BY O.OrderID ASC
	  

--แบบ Join
select O.OrderID, OrderDate, CompanyName, ShipCountry,Quantity 
from Orders As O INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
				 INNER JOIN Products As P ON OD.ProductID = P.ProductID
				 INNER JOIN Customers As C ON O.CustomerID = C.CustomerID
where ProductName = 'Tofu' And YEAR(OrderDate) = 1997
Order BY O.OrderID ASC
-----------------------------------------------------------------------------
/*11 : จงแสดงข้อมูลรหัสสินค้า ชื่อสินค้า ยอดขายรวม(ไม่คิดส่วนลด) ของสินค้าแต่ละรายการเฉพาะที่มีการสั่งซื้อในเดือน มค.-สค. ปี 1997*/
--แบบ Product
select P.ProductID, ProductName, SUM(OD.UnitPrice * Quantity) AS SumPrice
from Products AS P, [Order Details] AS OD, orders AS O
where P.ProductID = OD.ProductID AND OD.OrderID = O.OrderID
	  AND OrderDate Between '1997-01-01' AND '1997-08-31'
Group By P.ProductID, ProductName;

--แบบ Join
select P.ProductID, ProductName, SUM(OD.UnitPrice * Quantity) AS SumPrice
from Products AS P INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
				   INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
where OrderDate Between '1997-01-01' AND '1997-08-31'
Group By P.ProductID, ProductName;

-----------------------------------------------------------------------------
-- *** 4 ตาราง ****
/*12 : จงแสดงข้อมูลรหัสประเภทสินค้า ชื่อประเภทสินค้า ยอดสั่งซื้อรวม(ไม่คิดส่วนลด) เฉพาะที่มีการจัดส่งไปประเทศสหรัฐอเมริกา ในปี 1997*/
--แบบ Product
select C.CategoryID,CategoryName
from Categories AS C, Orders AS O, [Order Details] AS OD, Products AS P
where C.CategoryID = P.CategoryID AND O.OrderID = OD.OrderID
	  AND ShipCountry = 'USA' 
	  AND YEAR(ShippedDate) = 1997
Group By C.CategoryID,CategoryName
--แบบ Join
select C.CategoryID,CategoryName
from Categories As C INNER JOIN Products AS P ON C.CategoryID = P.CategoryID
					 INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
					 INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
where ShipCountry = 'USA' AND YEAR(ShippedDate) = 1997
Group By C.CategoryID,CategoryName
----------------------------------------------------------------------------
/*13 : จงแสดงรหัสพนักงาน ชื่อและนามสกุล(แสดงในคอลัมน์เดียวกัน) ยอดขายรวมของพนักงานแต่ละคน เฉพาะรายการขายที่จัดส่งโดยบริษัท Speedy Express 
ไปยังประเทศสหรัฐอเมริกา และทำการสั่งซื้อในปี 1997 */
--แบบ Product
select  E.EmployeeID, FirstName+' '+LastName AS EmployeeName,
	   SUM(OD.UnitPrice * Quantity) AS SumPrice
from Employees As E, Orders As O, Shippers As S, [Order Details] As OD
where E.EmployeeID = O.EmployeeID AND O.ShipVia = S.ShipperID
	  AND O.OrderID = OD.OrderID
	  AND CompanyName = 'Speedy Express' 
	  AND ShipCountry = 'USA'
	  AND YEAR(OrderDate) = 1997
group by E.EmployeeID, EmployeeName;

--แบบ Join
select  E.EmployeeID, FirstName+' '+LastName AS EmployeeName,
	   SUM(OD.UnitPrice * Quantity) AS SumPrice
from Employees As E INNER JOIN Orders As O ON E.EmployeeID = O.EmployeeID
					INNER JOIN Shippers As S ON O.ShipVia = S.ShipperID
					INNER JOIN [Order Details] As OD ON O.OrderID = OD.OrderID
where CompanyName = 'Speedy Express' 
	  AND ShipCountry = 'USA'
	  AND YEAR(OrderDate) = 1997
group by E.EmployeeID, EmployeeName;

--------------------------------------------------------------------------
/*14 : จงแสดงรหัสสินค้า ชื่อสินค้า ยอดขายรวม เฉพาะสินค้าที่นำมาจัดจำหน่ายจากประเทศญี่ปุ่น และมีการสั่งซื้อในปี 1997 และจัดส่งไปยังประเทศสหรัฐอเมริกา */
--แบบ Product
select P.ProductID, ProductName, SUM(OD.UnitPrice * Quantity) AS SumPrice
From Products AS P, Suppliers AS S, [Order Details] AS OD, Orders AS O
where P.SupplierID = S.SupplierID AND OD.ProductID = P.ProductID
	  AND O.OrderID = OD.OrderID
	  AND Country = 'Japan' 
	  AND YEAR(OrderDate) = 1997
	  AND ShipCountry = 'USA'
Group By P.ProductID, ProductName;

--แบบ Join
select P.ProductID, ProductName, SUM(OD.UnitPrice * Quantity) AS SumPrice
From Products AS P INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID
				   INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
				   INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
where Country = 'Japan' 
	  AND YEAR(OrderDate) = 1997
	  AND ShipCountry = 'USA'
Group By P.ProductID, ProductName;
----------------------------------------------------------------------------
-- *** 5 ตาราง ***
/*15 : จงแสดงรหัสลูกค้า ชื่อบริษัทลูกค้า ยอดสั่งซื้อรวมของการสั่งซื้อสินค้าประเภท Beverages ของลูกค้าแต่ละบริษัท  และสั่งซื้อในปี 1997 จัดเรียงตามยอดสั่งซื้อจากมากไปหาน้อย*/
--แบบ Product
select C.CustomerID, CompanyName, SUM(OD.UnitPrice * Quantity) AS SumPrice
From Customers AS C, Orders AS O, [Order Details] AS OD, Products AS P, Categories AS Ca
where C.CustomerID = O.CustomerID AND O.OrderID = OD.OrderID
	  AND OD.ProductID = P.ProductID AND P.CategoryID = Ca.CategoryID
	  AND CategoryName = 'Beverages'
	  AND YEAR(OrderDate) = 1997
group By C.CustomerID, CompanyName

--แบบ Join
select C.CustomerID, CompanyName, SUM(OD.UnitPrice * Quantity) AS SumPrice
from Customers AS C INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
					 INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
					 INNER JOIN Products AS P ON OD.ProductID = P.ProductID
					 INNER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryID
where CategoryName = 'Beverages'
	  AND YEAR(OrderDate) = 1997
group By C.CustomerID, CompanyName

---------------------------------------------------------------------------
/*16 : จงแสดงรหัสผู้จัดส่ง ชื่อบริษัทที่จัดส่ง จำนวนใบสั่งซื้อที่จัดส่งสินค้าประเภท Seafood ไปยังประเทศสหรัฐอเมริกา ในปี 1997 */
--แบบ Product
select S.ShipperID, CompanyName, COUNT(O.OrderID) AS NumOrders
From Shippers AS S, Orders AS O, [Order Details] AS OD, Products AS P, Categories AS C
where S.ShipperID = O.ShipVia AND O.OrderID = OD.OrderID
	  AND OD.ProductID = P.ProductID AND P.CategoryID = C.CategoryID
	  AND CategoryName = 'Seafood'
	  AND ShipCountry = 'USA'
	  AND YEAR(ShippedDate) = 1997
group By S.ShipperID, CompanyName;

--แบบ Join
select S.ShipperID, CompanyName, COUNT(O.OrderID) AS NumOrders
From Shippers AS S INNER JOIN Orders AS O ON S.ShipperID = O.ShipVia
				   INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
				   INNER JOIN Products AS P ON OD.ProductID = P.ProductID
				   INNER JOIN Categories AS C ON P.CategoryID = C.CategoryID
where CategoryName = 'Seafood'
	  AND ShipCountry = 'USA'
	  AND YEAR(ShippedDate) = 1997
group By S.ShipperID, CompanyName;

---------------------------------------------------------------------------
-- *** 6 ตาราง ***
/*17 : จงแสดงรหัสประเภทสินค้า ชื่อประเภท ยอดสั่งซื้อรวม(ไม่คิดส่วนลด) ที่ทำรายการขายโดย Margaret Peacock ในปี 1997 
และสั่งซื้อโดยลูกค้าที่อาศัยอยู่ในประเทศสหรัฐอเมริกา สหราชอาณาจักร แคนาดา */

--แบบ Product
select C.CategoryID, CategoryName, SUM(OD.UnitPrice * Quantity) AS SumPrice
from Categories AS C, Products AS P, [Order Details] AS OD, Orders AS O, Employees AS E, Customers AS Cu
where C.CategoryID = P.CategoryID AND P.ProductID = OD.ProductID
	  AND OD.OrderID = O.OrderID AND O.EmployeeID = E.EmployeeID
	  AND O.CustomerID = Cu.CustomerID
	  AND FirstName = 'Margaret' AND LastName = 'Peacock'
	  AND Country IN ('USA', 'UK', 'Canada')
	  AND YEAR(OrderDate) = 1997
Group By C.CategoryID, CategoryName;

--แบบ Join
select C.CategoryID, CategoryName, SUM(OD.UnitPrice * Quantity) AS SumPrice
from Categories AS C INNER JOIN Products AS P ON C.CategoryID = P.CategoryID
				   INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
				   INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
				   INNER JOIN Employees AS E ON O.EmployeeID = E.EmployeeID
				   INNER JOIN Customers AS Cu ON O.CustomerID = Cu.CustomerID
where FirstName = 'Margaret' AND LastName = 'Peacock'
	  AND Country IN ('USA', 'UK', 'Canada')
	  AND YEAR(OrderDate) = 1997
Group By C.CategoryID, CategoryName;
---------------------------------------------------------------------------
/*18 : จงแสดงรหัสสินค้า ชื่อสินค้า ยอดสั่งซื้อรวม(ไม่คิดส่วนลด) ของสินค้าที่จัดจำหน่ายโดยบริษัทที่อยู่ประเทศสหรัฐอเมริกา ที่มีการสั่งซื้อในปี 1997 
จากลูกค้าที่อาศัยอยู่ในประเทศสหรัฐอเมริกา และทำการขายโดยพนักงานที่อาศัยอยู่ในประเทศสหรัฐอเมริกา */

--แบบ Product
select P.ProductID, ProductName, SUM(OD.UnitPrice * Quantity) AS SumPrice
from Products AS P, Suppliers AS S, [Order Details] AS OD, Orders AS O, Customers AS Cu, Employees AS E
where P.SupplierID = S.SupplierID AND S.Country = 'USA'
	  AND OD.ProductID = P.ProductID AND OD.OrderID = O.OrderID
	  AND O.CustomerID = Cu.CustomerID AND Cu.Country = 'USA'
	  AND O.EmployeeID = E.EmployeeID AND E.Country = 'USA'
	  AND YEAR(OrderDate) = 1997
Group By P.ProductID, ProductName;

--แบบ Join
select P.ProductID, ProductName, SUM(OD.UnitPrice * Quantity) AS SumPrice
from Products AS P INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID
				   INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
				   INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
				   INNER JOIN Customers AS Cu ON O.CustomerID = Cu.CustomerID
				   INNER JOIN Employees AS E ON O.EmployeeID = E.EmployeeID
where S.Country = 'USA' AND Cu.Country = 'USA' AND E.Country = 'USA'
	  AND YEAR(OrderDate) = 1997
Group By P.ProductID, ProductName;

---------------------------------------------------------------------------

