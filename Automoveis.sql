-- Tabela AUTOMOVEIS
CREATE TABLE AUTOMOVEIS (
    Codigo INT PRIMARY KEY,
    Fabricante VARCHAR(100),
    Modelo VARCHAR(100),
    Ano INT,
    Pais VARCHAR(100),
    Preco_tabela DECIMAL(10, 2)
);

-- Tabela REVENDEDORA
CREATE TABLE REVENDEDORA (
    CNPJ VARCHAR(14) PRIMARY KEY,
    Nome VARCHAR(100),
    Proprietario VARCHAR(100),
    Cidade VARCHAR(100),
    Estado CHAR(2)
);

-- Tabela CONSUMIDORES
CREATE TABLE CONSUMIDORES (
    CPF VARCHAR(11) PRIMARY KEY,
    Nome VARCHAR(100),
    Sobrenome VARCHAR(100),
    Cidade VARCHAR(100),
    Estado CHAR(2)
);

-- Tabela GARAGENS
CREATE TABLE GARAGENS (
    CNPJ VARCHAR(14),
    Codigo INT,
    Quantidade INT,
    PRIMARY KEY (CNPJ, Codigo),
    FOREIGN KEY (CNPJ) REFERENCES REVENDEDORA(CNPJ)
	FOREIGN KEY (Codigo) REFERENCES AUTOMOVEIS(Codigo)
);

-- Tabela NEGOCIOS
CREATE TABLE NEGOCIOS (
    CNPJ VARCHAR(14),
    CPF VARCHAR(11),
    Codigo INT,
    DataC DATE,
    Preco DECIMAL(10, 2),
    PRIMARY KEY (CNPJ, CPF, Codigo, DataC),
    FOREIGN KEY (CNPJ) REFERENCES REVENDEDORA(CNPJ),
    FOREIGN KEY (CPF) REFERENCES CONSUMIDORES(CPF),
    FOREIGN KEY (Codigo) REFERENCES AUTOMOVEIS(Codigo)
);

INSERT INTO AUTOMOVEIS (Codigo, Fabricante, Modelo, Ano, Pais, Preco_tabela) VALUES
(1, 'Ford', 'Fiesta', 2020, 'Argentina', 50000.00),
(2, 'Chevrolet', 'Onix', 2021, 'Brasil', 60000.00),
(3, 'Volkswagen', 'Gol', 2019, 'Brasil', 55000.00),
(4, 'Renault', 'Kwid', 2020, 'Argentina', 52000.00);


INSERT INTO REVENDEDORA (CNPJ, Nome, Proprietario, Cidade, Estado) VALUES
('12345678901234', 'Revenda A', 'Proprietario A', 'São Paulo', 'SP'),
('98765432109876', 'Revenda B', 'Proprietario B', 'Rio de Janeiro', 'RJ');

INSERT INTO CONSUMIDORES (CPF, Nome, Sobrenome, Cidade, Estado) VALUES
('11111111111', 'João', 'Silva', 'Rio de Janeiro', 'RJ'),
('22222222222', 'Maria', 'Santos', 'São Paulo', 'SP');


INSERT INTO GARAGENS (CNPJ, Codigo, Quantidade) VALUES
('12345678901234', 1, 5),
('98765432109876', 2, 3);


INSERT INTO NEGOCIOS (CNPJ, CPF, Codigo, Ano, DataC, Preco) VALUES
('12345678901234', '11111111111', 1, 2020, '2024-03-20', 55000.00),
('98765432109876', '11111111111', 2, 2021, '2024-03-21', 70000.00),
('98765432109876', '22222222222', 2, 2021, '2024-03-22', 68000.00);

/* Criar as seguintes visões: 

1) Carros_Novos (Código, Fabricante, Modelo, Ano, País, Preço_tabela), com os automóveis de origem argentina fabricados no ano de 2020 
*/
CREATE VIEW Carros_novos AS
SELECT *
FROM AUTOMOVEIS
WHERE Pais = 'Argentina' AND Ano = 2020


-- 2) ) Auto_disponiveis (Revendedora, Fabricante, Modelo, quantidade), com os carros disponíveis para venda em cada revendedora (nome) 
CREATE VIEW Auto_disponiveis AS
SELECT 
    REVENDEDORA.Nome AS Revendedora,
    AUTOMOVEIS.Fabricante,
    AUTOMOVEIS.Modelo,
    COUNT(GARAGENS.Codigo) AS quantidade
FROM 
    REVENDEDORA
JOIN 
    GARAGENS ON REVENDEDORA.CNPJ = GARAGENS.CNPJ
JOIN 
    AUTOMOVEIS ON GARAGENS.Codigo = AUTOMOVEIS.Codigo
GROUP BY 
    REVENDEDORA.Nome, AUTOMOVEIS.Fabricante, AUTOMOVEIS.Modelo;


-- 3) Consumidores_Cariocas (Nome, CPF) com os consumidores que moram na cidade do rio de Janeiro
CREATE VIEW Consumidores_Cariocas AS
SELECT Nome, CPF
FROM CONSUMIDORES
WHERE Cidade = 'Rio de Janeiro'


-- 4) ) Neg_ok (Comprador, Revenda, Código, Ano, Data, Preço), registrando negócios com Lucro superior a 10% (dica: use como critério preco venda > preco de tabela * 1.1)
CREATE VIEW Neg_ok AS
SELECT 
	CONSUMIDORES.CPF AS Comprador, 
	REVENDEDORA.CNPJ AS Revendedora, 
	NEGOCIOS.Codigo AS Codigo, 
	NEGOCIOS.DataC AS Data, 
	NEGOCIOS.Preco AS Preço
FROM 
	NEGOCIOS
JOIN 
    REVENDEDORA ON NEGOCIOS.CNPJ = REVENDEDORA.CNPJ
JOIN 
    CONSUMIDORES ON NEGOCIOS.CPF = CONSUMIDORES.CPF
JOIN 
	AUTOMOVEIS ON NEGOCIOS.Codigo = AUTOMOVEIS.Codigo
WHERE NEGOCIOS.Preco > (AUTOMOVEIS.Preco_tabela * 1.1)

-- 5) Fabricantes_Estoque (Fabricante, quantidade), contendo fabricante e a quantidade total de automóveis fornecidos por ele nas garagens das revendedoras (dica: usar Group by na view)
CREATE VIEW Fabricantes_Estoque AS
SELECT 
    AUTOMOVEIS.Fabricante AS Fabricante,
    COUNT(GARAGENS.Quantidade) AS quantidade
FROM 
    AUTOMOVEIS
JOIN 
    GARAGENS ON AUTOMOVEIS.Codigo = GARAGENS.Codigo
GROUP BY 
    AUTOMOVEIS.Fabricante
