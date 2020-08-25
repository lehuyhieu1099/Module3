--1. Thông tin khách hàng (customer). Có bao nhiêu khách hàng?
SELECT * FROM Customers
SELECT COUNT([CustomerID]) AS 'Customer Count' FROM Customers 
-- 2. Thông tin loại hàng. Có bao nhiêu loại hàng (category), mỗi loại hàng có bao nhiêu sản phẩm (product)
SELECT * FROM Categories
SELECT COUNT(Categories.CategoryID) AS 'CATEGORY COUNT' FROM Categories
SELECT C.[CategoryID],[CategoryName],COUNT(C.CategoryID) AS 'COUNT'
FROM Categories C INNER JOIN Products P
ON  C.CategoryID = P.CategoryID
GROUP BY C.[CategoryID],[CategoryName]
-- Thông tin nhân viên. Có bao nhiêu nhân viên (Employee)? 
SELECT * FROM Employees
-- Nâng cao: bạn có thể truy vấn được tên người quản lý (là người được nhân viên báo cáo) không?
SELECT COUNT(EmployeeID) AS 'EMPLOYEE COUNT' FROM Employees
SELECT LastName,FirstName,ReportsTo FROM Employees
WHERE ReportsTo IS NULL
-- Thông tin các nhà cung cấp (supplier). Có bao nhiêu nhà cung cấp?
SELECT * FROM SUPPLIERS
SELECT COUNT(SupplierID) AS 'SUPPLIER COUNT' FROM SUPPLIERS
-- Đơn hàng (order) được lưu trữ gồm những năm nào?
SELECT DISTINCT DATENAME(YEAR,ORDERDATE) FROM Orders
-- Khách hàng thường sống ở những quốc gia nào? 
SELECT * FROM Customers
SELECT DISTINCT COUNTRY FROM Customers
-- Những quốc gia nào có nhà cung cấp?
SELECT DISTINCT COUNTRY AS 'COUNTRY OF SUPPLIERS'FROM Suppliers
-- Liệt kê các khách hàng không có số Fax?
SELECT * FROM CUSTOMERS
WHERE Fax IS NULL
ORDER BY CustomerID
-- Liệt kê các khách hàng sống ở Pháp. 
SELECT * FROM CUSTOMERS 
WHERE COUNTRY LIKE 'FRANCE'
--Liệt kê các khách hang sống ở Pháp và Tây Ban Nha
SELECT * FROM CUSTOMERS 
WHERE COUNTRY = 'FRANCE' OR COUNTRY ='SPAIN'
ORDER BY Country
-- Liệt kê các khách hàng không sống ở Châu Mỹ
SELECT * FROM CUSTOMERS
SELECT[CompanyName],[Country] FROM[dbo].[Customers]WHERE[Region] IS  NULL AND COUNTRY <> 'Mexico'
-- Liệt kê các hóa đơn của năm 1997
SELECT * 
FROM Orders
WHERE DATENAME(YEAR,ORDERDATE) = '1997'
-- Liệt kê 3 hóa đơn mới nhất
SELECT TOP(3) * 
FROM Orders 
ORDER BY DATENAME(YEAR,ORDERDATE) DESC
-- Liệt kê các hóa đơn có cước phí >100$.
SELECT * FROM ORDERS
WHERE Freight > 100
-- Tìm hóa đơn có cước phí cao nhất
SELECT TOP(1) * FROM ORDERS
ORDER BY Freight DESC
-- Hóa đơn cưới phí thấp nhất
SELECT TOP(1) * FROM ORDERS
ORDER BY Freight 
-- Đếm số hóa đơn bán được của năm 1996, 1997 và cả 2 năm 1996, 1997
SELECT * FROM ORDERS
-- 

SELECT COUNT(*) AS 'ORDER COUNT IN 1997' from Orders WHERE DATENAME(YEAR, OrderDate) = '1997'
select Order1996, Order1997, Order1996 + Order1997 as SumOf2Year from
(select COUNT(*) as Order1996 
 from Orders where  DATENAME(YEAR, OrderDate) = '1996') as Count1996
join
(select COUNT(*) as Order1997 
 from Orders where  DATENAME(YEAR, OrderDate) = '1997') as Count1997
ON 1 = 1
-- Tính đơn giá bình quân của tất cả sản phẩm?
SELECT AVG(FREIGHT)AS 'AVERAGE BILL' FROM Orders
-- Đơn giá của sản phẩm thuộc loại hải sản (mã loại là 8)
SELECT DISTINCT UnitPrice AS 'AVERAGE PRICE' FROM Products P 
WHERE P.ProductID = '8'
-- Liệt kê 3 sản phẩm có đơn giá mắc nhất.
SELECT TOP(3) * FROM Products 
ORDER BY UnitPrice DESC
 -- Liệt kê các sản phẩm có tên bắt đầu bằng ký tự N? Bắt đầu bằng ký tự N
 SELECT * FROM Products
 WHERE ProductName LIKE 'N%'
 
 SELECT * FROM Products
 WHERE ProductName LIKE 'N%' OR ProductName LIKE 'A%'

 SELECT * FROM Products
 WHERE ProductName NOT LIKE 'N%' OR ProductName NOT LIKE 'A%'
 -- Liệt kê các sản phẩm có đơn giá từ 100 đến 200
 SELECT * FROM Products
 WHERE UnitPrice BETWEEN 100 AND 200
 -- Liệt kê các sản phẩm có số lượng tồn kho (units in stock) thấp hơn định mức
-- tồn kho tối thiểu (reorder level)
SELECT * FROM Products
 WHERE UnitsInStock < ReorderLevel
 -- Tính số sản phẩm được cung cấp bởi nhà cung cấp Tokyo Traders (có mã là 4)
 SELECT * FROM Products
 WHERE CategoryID = 4





