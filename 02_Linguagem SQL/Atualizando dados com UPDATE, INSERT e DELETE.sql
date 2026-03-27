/*
 Autor: Emanuel Lima
 Data: 27/03/2026
 
 Descrição: Esse script põe em prática os comandos:

 - INSERT
 - UPDATE 
 - DELETE

 Versão 1.0

*/

/*****
INSERT
******/

-- Cria tabelas
CREATE TABLE Clientes (
	ClienteID INT NOT NULL IDENTITY PRIMARY KEY,
	Nome VARCHAR(50) NOT NULL,
	Bairro varchar(40) NULL,
	Sexo CHAR(1) NOT NULL DEFAULT 'M',
	Credito CHAR(1) NOT NULL DEFAULT 'A'
)

GO

INSERT Clientes (Nome,Bairro,Sexo,Credito)
VALUES ('Jose','Copacabana','M','A')

SELECT * FROM Clientes

-- DEFAULT
INSERT Clientes (Nome,Bairro)
VALUES ('Maria','Barra da Tijuca') -- Colocará os valores que foram definidos como DEFAULT nas colunas Sexo e Crédito

INSERT Clientes (Nome,Bairro,Sexo)
VALUES ('Paula','Ipanema',DEFAULT) -- Colocará os valores que foram definidos como DEFAULT nas colunas Sexo e Crédito

-- Tabela Tempororia LOCAL
SELECT * 
INTO #tmp_Clientes
FROM Clientes

SELECT * FROM #tmp_Clientes

DROP TABLE #tmp_Clientes

/******
UPDATE
*******/
UPDATE Clientes SET Sexo = 'F'
WHERE Nome = 'Maria'

-- Atualiza todas as linhas da coluna bairro
UPDATE Clientes SET Bairro = 'Leblon' 

-- UPDATE com JOIN
CREATE TABLE Vendas (
	VendaID INT NOT NULL IDENTITY PRIMARY KEY,
	ClienteID INT NOT NULL,
	Vendedor VARCHAR(50) NOT NULL,
	TotalVenda DECIMAL(10,2) NULL
)

GO

TRUNCATE TABLE Clientes

INSERT Clientes (Nome,Bairro,Sexo) VALUES ('Jose','Copacabana','M')
INSERT Clientes (Nome,Bairro,Sexo) VALUES ('Maria','Barra da Tijuca','F')
INSERT Clientes (Nome,Bairro,Sexo) VALUES ('Paula','Ipanema','F')

INSERT Vendas (ClienteID,Vendedor,TotalVenda) VALUES (1,'Paulo',5000.00)
INSERT Vendas (ClienteID,Vendedor,TotalVenda) VALUES (1,'Antonio',10000.00)
INSERT Vendas (ClienteID,Vendedor,TotalVenda) VALUES (2,'Paulo',2000.00)
INSERT Vendas (ClienteID,Vendedor,TotalVenda) VALUES (2,'Antonio',30000.00)

SELECT * FROM Clientes
SELECT * FROM Vendas
 
/*******
DELETE
********/

DELETE Vendas WHERE Vendedor = 'Paulo'

SELECT * FROM Clientes
SELECT * FROM Vendas

-- Excluir Clientes que nao compraram
DELETE c
FROM Clientes c LEFT JOIN Vendas v
ON c.ClienteID = v.ClienteID
WHERE v.VendaID IS NULL
 
/**********************
  Exclui tabelas
************************/
DROP TABLE IF exists dbo.Clientes 
DROP TABLE IF exists dbo.Vendas 
GO