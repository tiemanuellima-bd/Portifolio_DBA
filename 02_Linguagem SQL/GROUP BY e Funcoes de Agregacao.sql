/*
 Autor: Emanuel Lima
 Data: 22/03/2026
 
 Descrição: Esse script tem como objetivo mostrar alguns comandos de agragação como:

 - SUM
 - AVG
 - COUNT
 
 E o filtro HAVING, que serve como filtro semelhante ao	WHERE, porém o HAVING filtra funções de agragação. E o uso do GROUP BY para agrupar


 Versão 1.0

*/
USE AdventureWorks
GO

/*********************************
 Funcao de Agregacao
**********************************/ 
SELECT COUNT(*) AS TotLinhas, COUNT(SalesPersonID) AS TotSalesPerson,
AVG(SalesPersonID) AS MediaComNULL, AVG(isnull(SalesPersonID,0)) AS MediaSemNULL
FROM Sales.SalesOrderHeader

SELECT COUNT(*) AS TotLinhas
FROM Sales.SalesOrderHeader
-- 31.465 linhas

SELECT COUNT(CurrencyRateID) AS TotLinhas
FROM Sales.SalesOrderHeader
-- 13.976 linhas com NOT NULL na coluna CurrencyRateID

/**************************
 GROUP BY
***************************/ 
SELECT SalesPersonID,SUM(TotalDue) AS Total
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID
ORDER BY SalesPersonID

-- Ordena pelos vendedores que venderam mais
SELECT SalesPersonID,SUM(TotalDue) AS Total
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID
ORDER BY Total DESC

-- WHERE para remover o NULL
SELECT SalesPersonID,SUM(TotalDue) AS Total
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
ORDER BY Total DESC

-- HAVING filtro após o GROUP BY
SELECT SalesPersonID,SUM(TotalDue) AS Total
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
HAVING SUM(TotalDue) > 5000000 
ORDER BY Total DESC
