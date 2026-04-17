/*
 Autor: Emanuel Lima
 Data: 17/04/2026

 Descrição: Prática de Backups, Restore e simulação de erros

 Versão: 1.0

*/

USE master
GO
CREATE DATABASE TestDB
GO

-- Backup File
BACKUP DATABASE master TO DISK = 'C:\_HandsOn_AdmSQL\Backup\BackupMaster.bak'
GO

/***********************************
 Habilitar Compressão na Instância
************************************/
EXEC sp_configure 'show advanced options', 1
RECONFIGURE

EXEC sp_configure 'backup compression default', 1
RECONFIGURE

/*************************************** 
 Hands On Backup e Restore
****************************************/
USE TestDB
GO

CREATE TABLE dbo.Clientes 
(ClienteID int not null primary key,
Nome varchar(50),
Telefone varchar(20))
GO

SELECT * FROM TestDB.dbo.Clientes

/******************
 1) Backup FULL
*******************/
INSERT dbo.Clientes VALUES (1,'Jose','1111-1111')
GO

BACKUP DATABASE TestDB TO DISK = 'C:\_HandsOn_AdmSQL\Backup\TestDB.bak' WITH format,compression,stats=5


/******************
 2) Backup DIF
*******************/
INSERT dbo.Clientes VALUES (2,'Paula','2222-2222')
GO

BACKUP DATABASE TestDB TO DISK = 'C:\_HandsOn_AdmSQL\Backup\TestDB.bak' WITH noinit,compression,differential

/******************
 3) Backup LOG
*******************/
INSERT dbo.Clientes VALUES (3,'Luana','3333-3333')
GO

BACKUP LOG TestDB TO DISK = 'C:\_HandsOn_AdmSQL\Backup\TestDB.bak' WITH noinit,compression


RESTORE HEADERONLY FROM DISK = 'C:\_HandsOn_AdmSQL\Backup\TestDB.bak'

/* Tips de Backup

1 = FULL
2 = Transaction log
4 = File
5 = Differential database
6 = Differential file
7 = Partial
8 = Differential partial

*/

/***************************************
 4) Backup Log NO_TRUNCATE
****************************************/

INSERT dbo.Clientes VALUES (4,'Landry','4444-4444')
GO

-- SIMULANDO FALHA: Parar o serviço do SQL Server e renomear o arquivo de dados

BACKUP LOG TestDB TO DISK = 'C:\_HandsOn_AdmSQL\Backup\TestDB.bak' WITH noinit,compression,no_truncate
--WITH CONTINUE_AFTER_ERROR or WITH NO_TRUNCATE


/****************************
 Restore
*****************************/

-- Obtém informações de um Backup
RESTORE FILELISTONLY FROM DISK = 'C:\_HandsOn_AdmSQL\Backup\TestDB.bak' WITH file=1

-- Restaurar banco
RESTORE DATABASE TestDB FROM DISK = 'C:\_HandsOn_AdmSQL\Backup\TestDB.bak' WITH file=1, norecovery, replace
RESTORE DATABASE TestDB FROM DISK = 'C:\_HandsOn_AdmSQL\Backup\TestDB.bak' WITH file=2, norecovery
RESTORE LOG TestDB FROM DISK = 'C:\_HandsOn_AdmSQL\Backup\TestDB.bak' WITH file=3, norecovery
RESTORE LOG TestDB FROM DISK = 'C:\_HandsOn_AdmSQL\Backup\TestDB.bak' WITH file=4, recovery


SELECT * FROM TestDB.dbo.Clientes


/***********************************
 Histórico Backup
************************************/
SELECT * FROM msdb..backupset


-- Exclui banco
USE master
GO
DROP DATABASE IF exists TestDB