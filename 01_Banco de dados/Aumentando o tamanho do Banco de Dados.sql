/*

 Autor: Emanuel Lima
 Data: 2026-02-28

 Descrição: Esse script aumenta a capacidade do arquivo de dados para 100MB, para que isso aconteça é necessário um o comando MODIFY FILE
 para alterar o seu tamanho. E também foi criando um novo arquivo de dados com o comando ADD FILE, onde o seu tamanho inicial será de 100MB
 e terá um crescimento gradual de 50MB

 Versão 1.0

*/
USE master
GO


-- Cria um banco chamado HandsOn
DROP DATABASE IF exists HandsOn
GO
CREATE DATABASE HandsOn
GO

-- Aumentando a capacidade de armazenamento do arquivo de dados
EXEC SP_HELPDB 'HandsOn'

ALTER DATABASE HandsOn MODIFY FILE (NAME = N'HandsOn', SIZE = 100MB)

-- Adicionando novo arquivo de Dados
ALTER DATABASE HandsOn ADD FILE (NAME = N'HandsOn_File2', FILENAME = 'C:\MSSQL_Data\HandsOn_File2.ndf', SIZE = 100MB, FILEGROWTH = 50MB)




-- Exclui o banco HandsOn
USE master
GO
ALTER DATABASE HandsOn SET READ_ONLY WITH ROLLBACK IMMEDIATE
GO
DROP DATABASE IF exists HandsOn
