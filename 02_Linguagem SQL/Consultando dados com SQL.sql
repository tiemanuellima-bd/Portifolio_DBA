/*
 Autor: Emanuel Lima
 Data: 21/03/2026

 Descrição: Esse script mostra comandos essenciais da linguagem SQL como:

 - SELECT
 - WHERE
 - LIKE
 - AND, OR, BETWEEN, IN
 - ORDER BY
 - DISTINCT

 Versão 1.0

*/

USE AdventureWorks
GO

SELECT * FROM Person.Person -- Retorna todas a linhas e colunas da tabela

SELECT BusinessEntityID, LastName, FirstName, Title
FROM Person.Person -- Retorna todas as linhas das colunas selecionadas


/*****************************
 Filtros
******************************/
SELECT BusinessEntityID, LastName, FirstName, Title
FROM Person.Person
WHERE BusinessEntityID = 5 -- O WHERE faz com que seja retornado apenas BusinessEntityID = 5 

SELECT BusinessEntityID, LastName, FirstName, Title
FROM Person.Person
WHERE Title = 'Ms.' -- Retorna apenas onde o title "Ms." aparece

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice >= 100 -- Retorna apenas os preços maiores ou igual a 100

/***********
 LIKE
************/
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Name LIKE '%Ball%' -- Retorna os valores que contém 'Ball' em algum lugar da string

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Name LIKE '%Ball' -- Retornar apenas os valores que terminam com 'Ball'

/************ FIM LIKE ***************/


-- BETWEEN
SELECT ProductID, Name, Color, ListPrice
FROM  Production.Product
WHERE ListPrice BETWEEN 100 AND 1000 -- Retorna valores entre 100 e 1000

-- OR
SELECT ProductID, Name, Color, ListPrice
FROM  Production.Product
WHERE Color = 'Blue' OR Color = 'Black' -- Retorna apenas uma das condições

-- IN
SELECT ProductID, Name, Color, ListPrice
FROM  Production.Product
WHERE Color IN ('Blue', 'Black') -- Tem a mesma função do OR, onde retornará valores que contenham Blue ou Black

/***********************
 NULL
************************/
SELECT ProductID, Name, Color, ListPrice
FROM  Production.Product
WHERE Color IS NULL -- Retorna apenas valores nulos

SELECT ProductID, Name, Color, ListPrice
FROM  Production.Product
WHERE Color IS NOT NULL -- Retorna apenas valores não nulos


-- ORDER BY
SELECT ProductSubcategoryID,ProductID, Name, Color, ListPrice
FROM  Production.Product
ORDER BY ProductSubcategoryID, ListPrice DESC -- Ordena os valores de forma decrescente

-- DISTINCT
SELECT DISTINCT Color FROM Production.Product -- Retorna apenas uma cor distinta
