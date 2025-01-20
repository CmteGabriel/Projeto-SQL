--Usar a base de dados e verificar cada tabela
USE Northwind;
SELECT * FROM dbo.Categories;

SELECT * FROM Customers;

SELECT * FROM Employees;

SELECT * FROM EmployeeTerritories;

SELECT * FROM dbo.[Order Details];

SELECT * FROM Orders;

SELECT * FROM Products;

SELECT * FROM Region;

SELECT * FROM Shippers;

SELECT * FROM Suppliers;

SELECT * FROM Territories;

/*Qual o produto com maior preço por unidade?*/
SELECT TOP 1 * FROM Products
ORDER BY UnitPrice Desc;

/*Quais são os fornecedores localizados na Alemanha?*/
SELECT CompanyName,
	   City,
	   Country
FROM Suppliers
WHERE Country = 'Germany';

/*Quais países tiveram a maior média de preço de envio?*/
SELECT TOP 10 
       ShipCountry AS País,
	   AVG(Freight) AS 'Media_Preço'
FROM  Orders
GROUP BY ShipCountry
ORDER BY Media_Preço DESC;

/* Retorne a cidade referente a cada empregado*/
SELECT c.FirstName AS Nome,
	   c.LastName AS Sobrenome,
	   q.TerritoryDescription AS Cidade
FROM Employees c 
JOIN EmployeeTerritories p ON c.EmployeeID = p.EmployeeID
JOIN Territories q ON p.TerritoryID = q.TerritoryID;

/*Qual o produto mais vendido por categoria?*/
SELECT c.CategoryName,
       p.ProductName, 
       SUM(od.Quantity) AS TotalVendido
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY c.CategoryName, p.ProductName
ORDER BY c.CategoryName, TotalVendido DESC;

/*Qual o número de funcionários por Territórios?*/
SELECT EmployeeID, 
       COUNT(TerritoryID) AS TotalTerritorios
FROM 
    (SELECT * FROM EmployeeTerritories) AS Temp
GROUP BY EmployeeID;

/*Qual País possui mais clientes? E menos clientes?*/
--Mais clientes
SELECT TOP 5 Country AS País,
	   COUNT(CustomerID) AS TotalClientes
FROM Customers
GROUP BY Country
ORDER BY TotalCLientes DESC;

--Menos CLientes
SELECT TOP 5 Country AS País,
	   COUNT(CustomerID) AS TotalClientes
FROM Customers
GROUP BY Country
ORDER BY TotalCLientes ASC;

/*Retorne os funcionários que realizaram vendas entre fevereiro e setembro de 1997 */
SELECT c.FirstName,
       c.LastName,
	   q.OrderDate
FROM Orders q
JOIN Employees c ON q.EmployeeID = c.EmployeeID
WHERE OrderDate BETWEEN '1997-02-01 00:00:00.000' AND '1997-09-01 00:00:00.000';

/*Retorne os pedidos feitos há 27 anos atrás*/
SELECT * 
FROM Orders
WHERE OrderDate >= DATEADD(YEAR, -27, GETDATE());

/*Retorne todos os produtos comprados pelo cliente Queen Cozinha*/
SELECT a.CompanyName,
	   d.ProductName
FROM Customers a
JOIN Orders b ON a.CustomerID = b.CustomerID
JOIN [Order Details] c ON b.OrderID = c.OrderID
JOIN Products d ON c.ProductID = d.ProductID
WHERE a.CompanyName = 'Queen Cozinha';