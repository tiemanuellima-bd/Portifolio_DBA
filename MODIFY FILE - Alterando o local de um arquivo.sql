/*

 Autor: Emanuel Lima
 Data: 2026-03-02

 Descrição: Esse script altera a localização dos arquivos de dados

 Versão 1.0

*/


USE master
GO

-- Cria banco DB_HandsOn
DROP DATABASE IF exists DB_HandsOn
GO

CREATE DATABASE DB_HandsOn
GO

-- Retorna os arquivos existentes (Dados e Log)
SELECT name, physical_name 
FROM sys.master_files 
WHERE database_id = DB_ID('DB_HandsOn')


-- 1) Coloca o Banco em OffLine (É necessário que o banco esteja OFFLINE para a mudança)
ALTER DATABASE DB_HandsOn SET OFFLINE 
WITH ROLLBACK IMMEDIATE

-- 2) Altera a localização no metadata do SQL Server
ALTER DATABASE DB_HandsOn MODIFY FILE 
(name = 'DB_HandsOn_log', 
filename = 'C:\_HandsOn_Starter\DB_HandsOn_log.ldf')

-- 3) Dentro do explorador de arquivos transfira o arquivo para a pasta desejada

-- 4) Coloca o Banco OnLine
ALTER DATABASE DB_HandsOn SET ONLINE 
