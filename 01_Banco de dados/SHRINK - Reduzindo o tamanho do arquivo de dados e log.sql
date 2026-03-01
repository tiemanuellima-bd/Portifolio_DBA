/*

 Autor: Emanuel Lima
 Data: 2026-03-01

 Descrição: Esse script reduz o tamanho dos arquivos de dados e de log através dos comandos DBCC SHRINKDATABASE e DBCC SHRINKFILE

 Versão 1.0

*/

USE master
GO

-- Cria Banco para Hands On
DROP DATABASE IF exists HandsOn
GO
CREATE DATABASE HandsOn
GO

--  Create tabela no banco HandsOn
DROP TABLE IF exists HandsOn.dbo.tb_Teste
GO
CREATE TABLE HandsOn.dbo.tb_Teste ( 
tb_Teste_ID int identity CONSTRAINT pk_tb_Teste PRIMARY KEY,
ColunaGrande nchar(2000),
ColunaBigint bigint)
GO


/*
 Executar todo o bloco para popular a tabela com linhas
 - Leva 1 minuto
*/
SET NOCOUNT ON
GO

-- Inclui 100.000 linhas
INSERT HandsOn.dbo.tb_Teste (ColunaGrande,ColunaBigint)
VALUES('Teste',12345)
GO 100000
-- FIM BLOCO

USE HandsOn
GO
SELECT name AS Name, size * 8 /1024. as Tamanho_MB,  
FILEPROPERTY(name,'SpaceUsed') * 8 /1024. as Espaco_Utilizado_MB,
CAST(FILEPROPERTY(name,'SpaceUsed') as decimal(10,4))
/ CAST(size as decimal(10,4)) * 100 as Percentual_Utilizado
FROM sys.database_files

/*
Name			Tamanho_MB	Espaco_Utilizado_MB	Percentual_Utilizado
HandsOn			456.000000	395.875000			86.814692982456100
HandsOn_log		328.000000	234.398437			71.462938262195100
*/

-- Reduz mas mantém 10% de espaço livre
DBCC SHRINKDATABASE('HandsOn', 10 )

-- Exclui metade das linhas
DELETE top(50000) HandsOn.dbo.tb_Teste

-- Reduz para 250MB o tamanho do arquivo de dados HandsOn
USE HandsOn
GO
DBCC SHRINKFILE (N'HandsOn' , 250)


-- Excluir Banco

USE master
GO
ALTER DATABASE HandsOn SET READ_ONLY WITH ROLLBACK IMMEDIATE
GO
DROP DATABASE IF exists HandsOn
