--Nome do produto, nome do fornecedor, nome da categoria, preço e estoque
SELECT p.ProductName, s.CompanyName, c.CategoryName, p.UnitPrice, P.UnitsInStock 
FROM Products p
JOIN Suppliers s on p.SupplierID = s.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID;

--Ocultar produtos com estoque zerado e descontinuados
SELECT p.ProductName, p.UnitsInStock
FROM Products p 
WHERE p.UnitsInStock > 0 AND p.Discontinued = 0;

--Listar produtos com estoque zerado ou descontinuados
SELECT p.ProductName, p.UnitsInStock
FROM Products p 
WHERE p.UnitsInStock > 0 OR p.Discontinued = 1;

--Nome do vendedor e a quantidade de vendas que ele possui
SELECT e.FirstName, COUNT(O.OrderID) 
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName;

--Nome do vendedor e quantidade de territórios aos quais ele está vinculado
SELECT e.FirstName, COUNT(et.TerritoryID) AS TerritoryCount
FROM Employees e
LEFT JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
GROUP BY e.FirstName;

--Vendas ordenadas por valor total, do maior ao menor
SELECT
CONCAT (e.firstname, ' ', e.lastname) AS name,
	COUNT(T.TERRITORYID) AS TERRITORIES
FROM DBO.EMPLOYEES E
JOIN EMPLOYEETERRITORIES T ON T.EMPLOYEEID = E.EMPLOYEEID
GROUP BY CONCAT(E.FIRSTNAME, ' ', E.LASTNAME)

--Vendas em que o produto foi vendido mais barato do que o valor de compra