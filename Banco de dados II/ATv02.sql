SELECT p.ProductName, s.CompanyName, c.CategoryName, p.UnitPrice, P.UnitsInStock 
FROM Products p
JOIN Suppliers s on p.SupplierID = s.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID;

SELECT p.ProductName, p.UnitsInStock
FROM Products p 
WHERE p.UnitsInStock > 0 AND p.Discontinued = 0;

SELECT p.ProductName, p.UnitsInStock
FROM Products p 
WHERE p.UnitsInStock > 0 OR p.Discontinued = 1;

select * from dbo.products;


--Nome do produto, nome do fornecedor, nome da categoria, preço e estoque
SELECT
	P.PRODUCTNAME AS PRODUCT,
	S.COMPANYNAME SUPPLIER,
	C.CATEGORYNAME AS CATEGORY,
	P.UNITPRICE AS PRICE,
	P.UNITSINSTOCK AS STOCK
FROM DBO.PRODUCTS P
JOIN DBO.SUPPLIERS S ON S.SUPPLIERID = P.SUPPLIERID
JOIN DBO.CATEGORIES C ON C.CATEGORYID = P.CATEGORYID
GO

--Ocultar produtos com estoque zerado e descontinuados
SELECT
	P.PRODUCTNAME AS PRODUCT,
	S.COMPANYNAME SUPPLIER,
	C.CATEGORYNAME AS CATEGORY,
	P.UNITPRICE AS PRICE,
	P.UNITSINSTOCK AS STOCK
FROM DBO.PRODUCTS P
JOIN DBO.SUPPLIERS S ON S.SUPPLIERID = P.SUPPLIERID
JOIN DBO.CATEGORIES C ON C.CATEGORYID = P.CATEGORYID
WHERE P.UNITSINSTOCK > 0
AND P.DISCONTINUED = 0
GO

--Listar produtos com estoque zerado ou descontinuados
SELECT
	P.PRODUCTNAME AS PRODUCT,
	S.COMPANYNAME SUPPLIER,
	C.CATEGORYNAME AS CATEGORY,
	P.UNITPRICE AS PRICE,
	P.UNITSINSTOCK AS STOCK
FROM DBO.PRODUCTS P
JOIN DBO.SUPPLIERS S ON S.SUPPLIERID = P.SUPPLIERID
JOIN DBO.CATEGORIES C ON C.CATEGORYID = P.CATEGORYID
WHERE P.UNITSINSTOCK = 0
AND P.DISCONTINUED = 1
GO

--Nome do vendedor e a quantidade de vendas que ele possui
SELECT
	CONCAT(E.FIRSTNAME, ' ', E.LASTNAME) AS NAME,
	COUNT(O.ORDERID) AS ORDERS
FROM DBO.EMPLOYEES E
JOIN DBO.ORDERS O ON O.EMPLOYEEID = E.EMPLOYEEID
GROUP BY CONCAT(E.FIRSTNAME, ' ', E.LASTNAME)
GO

--Nome do vendedor e quantidade de territórios aos quais ele está vinculado
SELECT
	CONCAT(E.FIRSTNAME, ' ', E.LASTNAME) AS NAME,
	COUNT(T.TERRITORYID) AS TERRITORIES
FROM DBO.EMPLOYEES E
JOIN EMPLOYEETERRITORIES T ON T.EMPLOYEEID = E.EMPLOYEEID
GROUP BY CONCAT(E.FIRSTNAME, ' ', E.LASTNAME)
GO

FROM Products p
JOIN Suppliers s on p.SupplierID = s.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID;

SELECT p.ProductName, p.UnitsInStock
FROM Products p 
WHERE p.UnitsInStock > 0 AND p.Discontinued = 0;

SELECT p.ProductName, p.UnitsInStock
FROM Products p 
WHERE p.UnitsInStock > 0 OR p.Discontinued = 1;

SELECT e.FirstName, COUNT(O.OrderID) 
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName;
