-- Liệt kê tên khách hàng mua hàng nhiều nhất trong năm 1997? Trong mỗi năm?

CREATE PROCEDURE procedure_BestSales
AS
BEGIN
-- khai báo biến
declare @tbYear TABLE([year] int)
declare @year int
declare @BestSalesOfYear TABLE([year] int,Customer varchar(5),Amount float)

-- THÊM VÀO TBYEAR
insert into @tbYear
select distinct year(OrderDate) [Year] from Orders
--dùng vòng lặp
while (exists (select * from @tbYear))
	begin
		set @year = (select top(1) [Year] from @tbYear)
		insert into @BestSalesOfYear
		SELECT TOP(1) YEAR(O.OrderDate)as 'year',o.CustomerID as 'custumer', ROUND(SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity),3) AS 'Amount'
		FROM [dbo].[Customers] C
		INNER JOIN [dbo].[Orders] O ON O.CustomerID = C.CustomerID
		INNER JOIN [dbo].[Order Details] OD ON OD.OrderID = O.OrderID
		GROUP BY YEAR(O.OrderDate),o.CustomerID
		having YEAR(O.OrderDate) = @year
		ORDER BY YEAR(O.OrderDate),ROUND(SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity),3) DESC
		delete from @tbYear where [Year] = @year
	end
	select * from @BestSalesOfYear
end




procedure_BestSales


        