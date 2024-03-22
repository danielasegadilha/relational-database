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
