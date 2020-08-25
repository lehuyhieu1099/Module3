-- 1. Liệt kê thông tin các hóa đơn bao gồm số hóa đơn, ngày và ngày 
-- giao hàng trong tháng 7/1997? 
SELECT OrderID,OrderDate,ShippedDate FROM Orders
WHERE DATENAME(MONTH,SHIPPEDDATE) ='JULY' AND DATENAME(YEAR,SHIPPEDDATE) ='1997'
-- Trong quý 1 năm 1997? 
SELECT OrderID,OrderDate,ShippedDate FROM Orders
WHERE DATENAME(MONTH,SHIPPEDDATE) = 'JANUARY' OR DATENAME(MONTH,SHIPPEDDATE) ='APRIL' AND DATENAME(YEAR,SHIPPEDDATE) ='1997'
--Trong nữa tháng đầu tiên của tháng 7/1997?
SELECT OrderID,OrderDate,ShippedDate FROM Orders
WHERE DATENAME(DAY,SHIPPEDDATE) <= '15' AND DATENAME(MONTH,SHIPPEDDATE) ='JULY' AND DATENAME(YEAR,SHIPPEDDATE) ='1997'
-- Liệt kê thông tin STT, Tên, Ngày sinh của nhân viên.
SELECT * FROM Employees
SELECT EmployeeId AS STT, LASTNAME, FIRSTNAME,BIRTHDATE FROM Employees
-- Liệt kê các khách hàng đã mua hàng trong năm 1997
SELECT * FROM Customers C INNER JOIN Orders O ON O.CustomerID = C.CustomerID
WHERE DATENAME(YEAR,OrderDate) = '1997'
-- Liệt kê các sản phẩm do công ty Exotic Liquids cung cấp trong năm 1997 và 1998

SELECT DISTINCT P.ProductName FROM Products P
INNER JOIN Suppliers S 
ON S.SupplierID = P.SupplierID 
INNER JOIN [dbo].[Order Details] OD 
ON OD.ProductID = P.ProductID
INNER JOIN Orders O
ON O.OrderID = OD.OrderID
WHERE S.CompanyName = 'Exotic Liquids' 
AND (DATENAME(YEAR,O.OrderDate) = '1997'OR DATENAME(YEAR,O.OrderDate) = '1998')
-- Liệt kê chi tiết về ID, Tên sản phẩm, Số lượng, Đơn giá, Giảm giá, Thành tiền 
--(trước giảm giá) của các đơn đặt hàng
SELECT   P.ProductID,P.ProductName, OD.UnitPrice,O.Freight,OD.Quantity,
(OD.UnitPrice*OD.Quantity) AS 'DON GIA'
FROM ORDERS O 
INNER JOIN [dbo].[Order Details] OD ON OD.OrderID = O.OrderID
INNER JOIN [dbo].[Products] P ON P.ProductID = OD.ProductID  
-- Liệt kê các thông tin chi tiết trên của các đơn đặt hàng trong tháng 1/1998
SELECT  DISTINCT P.ProductID,P.ProductName, OD.UnitPrice,O.Freight,OD.Quantity
FROM ORDERS O 
INNER JOIN [dbo].[Order Details] OD ON OD.OrderID = O.OrderID
INNER JOIN [dbo].[Products] P ON P.ProductID = OD.ProductID
WHERE YEAR(O.OrderDate) = 1998 AND MONTH(O.OrderDate) =1
--Tính thêm số tiền thanh toán trên mỗi hóa đơn
SELECT DISTINCT O.OrderID,
ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1) AS 'PAID'
FROM Orders O
INNER JOIN [dbo].[Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY O.OrderID
-- Đếm số hóa đơn bán được trong mỗi năm
SELECT YEAR(O.OrderDate) AS 'YEAR' ,
COUNT(DISTINCT O.OrderID) FROM ORDERS O
GROUP BY YEAR(O.OrderDate) 
ORDER BY YEAR(O.OrderDate)
-- 8. Tính tổng doanh thu bán hàng:
  -- a. Theo từng năm
  SELECT YEAR(O.OrderDate) AS 'YEAR',
  ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1) AS 'PAID' 
  FROM Orders O
  INNER JOIN [dbo].[Order Details] OD ON OD.OrderID = O.OrderID
  GROUP BY YEAR(O.OrderDate)
  ORDER BY YEAR(O.OrderDate)
 -- b. Theo từng quý năm 1997
 SELECT YEAR(O.OrderDate) AS 'YEAR',
 DATEPART(QUARTER,O.OrderDate) AS 'QUARTER',
  ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1) AS 'PAID' 
  FROM Orders O
  INNER JOIN [dbo].[Order Details] OD ON OD.OrderID = O.OrderID
  WHERE YEAR(O.OrderDate) = '1997'
  GROUP BY DATEPART(QUARTER,O.OrderDate),YEAR(O.OrderDate)
  ORDER BY DATEPART(QUARTER,O.OrderDate)
  -- Tính tổng doanh số bán hàng của mỗi nhân viên trong năm 1997
  SELECT E.EmployeeID,E.FirstName, ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1)
  FROM Orders O
  INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
  INNER JOIN [dbo].[Order Details] OD ON OD.OrderID = O.OrderID
  GROUP BY E.EmployeeID,E.FirstName
  ORDER BY E.EmployeeID
  -- Tìm nhân viên có doanh số bán hàng cao nhất.
  SELECT TOP(1)
  E.EmployeeID,E.FirstName, ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1)
  FROM Orders O
  INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
  INNER JOIN [dbo].[Order Details] OD ON OD.OrderID = O.OrderID
  GROUP BY E.EmployeeID,E.FirstName
  ORDER BY ROUND(SUM((1-OD.Discount)*OD.Quantity*OD.UnitPrice),1)







  