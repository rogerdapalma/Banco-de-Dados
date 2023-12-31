--Crie uma vis�o que liste todos os funcion�rios que n�o s�o chefes.
CREATE VIEW NOT_MANAGERS AS
	SELECT EMPLOYEEID, FIRSTNAME, LASTNAME, TITLE
	FROM EMPLOYEES
	WHERE TITLE NOT LIKE '%Manager%' AND TITLE NOT LIKE '%President%'

--Fa�a uma vis�o que liste a quantidade de vendas que cada produto (o quanto cada produto foi vendido).
CREATE VIEW PRODUCTS_SALES AS
	SELECT P.PRODUCTID, P.PRODUCTNAME, COUNT(OD.ORDERID) AS SALES
	FROM PRODUCTS P
	LEFT JOIN [ORDER DETAILS] OD ON OD.PRODUCTID = P.PRODUCTID
	GROUP BY P.PRODUCTID, P.PRODUCTNAME

--Fa�a uma vis�o que liste os territ�rios e quantos vendedores est�o vinculados a ele
CREATE VIEW TERRITORY_EMPLOYEES AS
	SELECT T.TERRITORYID, T.TERRITORYDESCRIPTION, COUNT(ET.EMPLOYEEID) AS EMPLOYEES
	FROM TERRITORIES T
	LEFT JOIN EMPLOYEETERRITORIES ET ON ET.TERRITORYID = T.TERRITORYID
	GROUP BY T.TERRITORYID, T.TERRITORYDESCRIPTION


--Fa�a uma vis�o que retorne o nome do cliente da venda de maior valor.
CREATE VIEW BIGGEST_SALE AS
	SELECT TOP 1 C.CONTACTNAME, SUM(OD.UNITPRICE * OD.QUANTITY) AS TOTAL_SALES
	FROM [ORDER DETAILS] OD
	JOIN ORDERS O ON OD.ORDERID = O.ORDERID
	JOIN CUSTOMERS C ON O.CUSTOMERID = C.CUSTOMERID
	GROUP BY C.CONTACTNAME
	ORDER BY TOTAL_SALES DESC

--Fa�a uma vis�o que liste os vendedores ordenados pela lucratividade.
CREATE VIEW SALESMAN_PROFIT AS
	SELECT E.FIRSTNAME, E.LASTNAME, CAST(SUM((OD.UNITPRICE * OD.QUANTITY) - OD.DISCOUNT) AS DECIMAL(10, 2)) AS PROFIT
	FROM EMPLOYEES E
	JOIN ORDERS O ON E.EMPLOYEEID = O.EMPLOYEEID
	JOIN [ORDER DETAILS] OD ON O.ORDERID = OD.ORDERID
	GROUP BY E.FIRSTNAME, E.LASTNAME
	ORDER BY PROFIT DESC


--Fa�a uma vis�o que retorne os produtos, seu fornecedor, sua categoria, seu
--pre�o e a informa��o de ele estar descontinuado ou n�o, para aqueles que possuem estoque.
CREATE VIEW AVAILABLE_PRODUCTS AS
	SELECT P.PRODUCTID, P.PRODUCTNAME, S.COMPANYNAME AS SUPPLIER, C.CATEGORYNAME AS CATEGORY, P.UNITPRICE,
		CASE WHEN P.DISCONTINUED = 1 THEN 'Yes' ELSE 'No' END AS DISCONTINUED
	FROM PRODUCTS P
	JOIN SUPPLIERS S ON P.SUPPLIERID = S.SUPPLIERID
	JOIN CATEGORIES C ON P.CATEGORYID = C.CATEGORYID
	WHERE P.UNITSINSTOCK > 0
