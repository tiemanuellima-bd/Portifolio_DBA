/*
 Autor: Emanuel Lima
 Data: 19/05/2026
 
 Descrição: Esse Script faz a carga de dados de uma planilha Excel para dentro de um Banco de dados SQL,
			usando o BULK INSERT

 Versão 1.0

*/

-- Criando o banco
CREATE DATABASE FRAUDE

-- Criando a tabela para receber o Excel
CREATE TABLE BaseFraude (
	DataTransacao DATETIME,
	Cliente VARCHAR(50),
	TipoTransacao VARCHAR(50),
	Valor_Transacoes FLOAT,
	Bandeira VARCHAR(50),
	Aprovado VARCHAR(10)
)

-- Inserindo da pasta para o banco

BULK INSERT BaseFraude -- Carrega os dados de um arquivo CSV para a BaseFraude
FROM 'D:\TempCarga\Base_Fraude.csv' -- Caminho completo do arquivo CSV
WITH (
	FIRSTROW = 2, -- Importa a partir da segunda linha
	FIELDTERMINATOR = ',', -- Define o separador de condicao, (CSV, |)
	ROWTERMINATOR = '\n', -- Define a cada linha como quebra
	CODEPAGE = '65001' -- Define o codigo de paginas com UTF 8
)

SELECT * FROM BaseFraude


