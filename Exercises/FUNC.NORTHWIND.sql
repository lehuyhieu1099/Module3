ALTER FUNCTION BestSales()
RETURNS @BestSalesOfYear TABLE (
				[year] INT,
				Customer VARCHAR(50),
				Amount FLOAT
				)
AS
BEGIN
DECLARE @tbYear TABLE([year] INT)
DECLARE @year INT
INSERT INTO @tbYear SELECT DISTINCT YEAR(OrderDate) [Year] FROM Orders
WHILE (EXISTS (SELECT * FROM @tbYear))
	BEGIN
	
		SET @year = (SELECT TOP(1) [Year] FROM @tbYear)
		INSERT INTO @BestSalesOfYear
		SELECT TOP(1) YEAR(O.OrderDate)as 'YEAR',o.CustomerID as 'CUSTOMER', ROUND(SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity),3)
		FROM [dbo].[Customers] C
		INNER JOIN [dbo].[Orders] O ON O.CustomerID = C.CustomerID
		INNER JOIN [dbo].[Order Details] OD ON OD.OrderID = O.OrderID
		GROUP BY YEAR(O.OrderDate),o.CustomerID
		having YEAR(O.OrderDate) = @year
		ORDER BY YEAR(O.OrderDate),ROUND(SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity),3) DESC
		DELETE FROM @tbYear WHERE [Year] = @year		
	END
RETURN
END
 SELECT * FROM bestsales() ORDER BY [YEAR] DESC