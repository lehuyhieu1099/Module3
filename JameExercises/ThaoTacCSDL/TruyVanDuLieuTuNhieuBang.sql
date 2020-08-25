-- 1. Liệt kê thông tin ID, Họ tên, Tuổi của nhân viên
SELECT * FROM Employees
SELECT E.EmployeeID,CONCAT(E.FirstName,' ',E.LastName) AS 'FULL NAME',
(2020 -YEAR(E.BirthDate)) AS 'AGE' 
FROM Employees E
-- Bổ sung thêm thông tin về quốc gia. 
SELECT E.EmployeeID,CONCAT(E.FirstName,' ',E.LastName) AS 'FULL NAME',
(2020 -YEAR(E.BirthDate)) AS 'AGE' ,E.Country
FROM Employees E
--Lọc lấy các khách hàng thuộc nước Pháp và Tây Ban Nha cùng mã 
--số hóa đơn khách đã mua trong quý 3 và 4 của năm 1997.
--Giới hạn lại trong các hóa đơn khách đã mua trong quý 3 và 4 của năm 1997 
SELECT DISTINCT C.CustomerID ,
	  O.OrderID,
	  YEAR(O.OrderDate) AS 'YEAR',
	  C.Country 
	  FROM Orders O
	  INNER JOIN Customers C 
	  ON C.CustomerID = O.CustomerID
	  WHERE (DATEPART(QUARTER,O.OrderDate) = 3 
	  OR DATEPART(QUARTER,O.OrderDate) = 4) 
	  AND YEAR(O.OrderDate) = 1997
	  AND (C.Country = 'FRANCE' OR O.ShipCountry = 'SPAIN')
	  
-- Tính tổng cước phí mỗi khách hàng đã trả cho mỗi nhà chuyên chở. 
--Cước phí: Freight, Nhà chuyên chở: ShipVia/Shipper
SELECT C.CustomerID,S.ShipperID,S.CompanyName,
SUM(O.Freight)
FROM Orders O
INNER JOIN Shippers S ON S.ShipperID = O.ShipVia
INNER JOIN Customers C ON C.CustomerID = O.CustomerID
GROUP BY S.ShipperID,S.CompanyName,C.CustomerID
-- Tính tổng số tiền mỗi khách đã mua trong năm 1997.
SELECT O.CustomerID,
ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1)
FROM Customers C
INNER JOIN ORDERS O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY O.CustomerID
ORDER BY O.CustomerID
-- Tính tổng doanh số mỗi nhân viên đã bán được trong năm 1997
SELECT E.EmployeeID,
ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1)
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY E.EmployeeID
ORDER BY E.EmployeeID
-- Tính tổng tiền bán được của mỗi loại sản phẩm trong năm 1997? 
SELECT P.ProductID,P.ProductName,
ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1)
FROM [Order Details] OD
INNER JOIN Products P ON P.ProductID = OD.ProductID
INNER JOIN Orders O ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY P.ProductID,P.ProductName
ORDER BY P.ProductID
--Từng quý năm 1997?
SELECT P.ProductID,P.ProductName,
DATEPART(QUARTER,O.OrderDate) AS 'QUARTER',
ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1) AS 'DOANH SO'
FROM [Order Details] OD
INNER JOIN Products P ON P.ProductID = OD.ProductID
INNER JOIN Orders O ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 1997 
GROUP BY P.ProductID,P.ProductName,DATEPART(QUARTER,O.OrderDate)
ORDER BY DATEPART(QUARTER,O.OrderDate)

--  Liệt kê các quốc gia có trên 3 khách hàng
SELECT C.Country,
COUNT(C.Country) AS 'COUNT'
FROM Customers C
GROUP BY C.Country
HAVING COUNT(C.Country)>3
-- Liệt kê loại sản phẩm có nhiều sản phẩm nhất
SELECT *
 FROM Products 
 WHERE UnitsInStock = (SELECT MAX(UnitsInStock) FROM Products)
 -- Liệt kê tên khách hàng mua hàng nhiều nhất trong năm 1997? 
 SELECT TOP(1)
 O.CustomerID,
 ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1)
 FROM [dbo].[Order Details] OD
 INNER JOIN Orders O ON O.OrderID = OD.OrderID
 INNER JOIN Customers C ON C.CustomerID = O.CustomerID
 WHERE YEAR(O.OrderDate) = 1997
 GROUP BY O.CustomerID
 ORDER BY ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1) DESC
 -- Trong mỗi năm?
 SELECT TOP(1)
 YEAR(O.OrderDate) AS 'YEAR',
 O.CustomerID,
 ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1)
 FROM [dbo].[Order Details] OD
 INNER JOIN Orders O ON O.OrderID = OD.OrderID
 INNER JOIN Customers C ON C.CustomerID = O.CustomerID
 WHERE YEAR(O.OrderDate) = 1996
 GROUP BY YEAR(O.OrderDate), O.CustomerID
 ORDER BY ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1) DESC 
 
 
 SELECT TOP(1)
 YEAR(O.OrderDate) AS 'YEAR',
 O.CustomerID,
 ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1)
 FROM [dbo].[Order Details] OD
 INNER JOIN Orders O ON O.OrderID = OD.OrderID
 INNER JOIN Customers C ON C.CustomerID = O.CustomerID
 WHERE YEAR(O.OrderDate) = 1997
 GROUP BY YEAR(O.OrderDate), O.CustomerID
 ORDER BY ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1) DESC 

 SELECT TOP(1)
 YEAR(O.OrderDate) AS 'YEAR',
 O.CustomerID,
 ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1)
 FROM [dbo].[Order Details] OD
 INNER JOIN Orders O ON O.OrderID = OD.OrderID
 INNER JOIN Customers C ON C.CustomerID = O.CustomerID
 WHERE YEAR(O.OrderDate) = 1998
 GROUP BY YEAR(O.OrderDate), O.CustomerID
 ORDER BY ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1) DESC 













