CREATE TABLE Ambulatorio (
nroa INT PRIMARY KEY,
andar INT,
capacidade INT,
)

CREATE TABLE Medicos (
codm INT PRIMARY KEY, 
CPF CHAR(11) NOT NULL,
nome VARCHAR(80),
idade INT, 
cidade VARCHAR(80),
especialidade VARCHAR(45),
nroa INT,
FOREIGN KEY (nroa) REFERENCES Ambulatorio(nroa)
)

CREATE TABLE Pacientes (
codp INT PRIMARY KEY,
CPF CHAR(11) NOT NULL,
nome VARCHAR(80),
sexo CHAR(1),
idade INT, 
cidade VARCHAR(80),
doença VARCHAR(45)
)

CREATE TABLE Consultas (
codm INT,
codp INT, 
data DATE, 
hora TIME,
PRIMARY KEY (codm, codp),
FOREIGN KEY (codm) REFERENCES Medicos(codm),
FOREIGN KEY (codp) REFERENCES Pacientes(codp),
)

CREATE TABLE Funcionarios (
codf INT PRIMARY KEY, 
CPF CHAR(11) NOT NULL,
nome VARCHAR(80), 
idade INT, 
cidade VARCHAR(80),
salario DECIMAL(10, 2)
)

INSERT INTO Ambulatorio (nroa, andar, capacidade)
VALUES
(1, 1, 20),
(2, 2, 30),
(3, 1, 15),
(4, 3, 25),
(5, 2, 20),
(6, 1, 10),
(7, 4, 35),
(8, 2, 25),
(9, 3, 30),
(10, 1, 20);

-- Dados fictícios para a tabela Medicos
INSERT INTO Medicos (codm, CPF, nome, idade, cidade, especialidade, nroa)
VALUES
(1, '12345678901', 'Dr. Silva', 35, 'São Paulo', 'Cardiologia', 1),
(2, '23456789012', 'Dra. Santos', 42, 'Rio de Janeiro', 'Dermatologia', 2),
(3, '34567890123', 'Dr. Oliveira', 40, 'São Paulo', 'Ortopedia', 3),
(4, '45678901234', 'Dra. Pereira', 38, 'Rio de Janeiro', 'Pediatria', 4),
(5, '56789012345', 'Dr. Souza', 45, 'São Paulo', 'Ginecologia', 5),
(6, '67890123456', 'Dra. Martins', 39, 'Rio de Janeiro', 'Oftalmologia', 6),
(7, '78901234567', 'Dr. Costa', 37, 'São Paulo', 'Neurologia', 7),
(8, '89012345678', 'Dra. Lima', 41, 'Rio de Janeiro', 'Psiquiatria', 8),
(9, '90123456789', 'Dr. Santos', 36, 'São Paulo', 'Cardiologia', 9),
(10, '01234567890', 'Dra. Fernandes', 43, 'Rio de Janeiro', 'Ortopedia', 10);

-- Dados fictícios para a tabela Pacientes
INSERT INTO Pacientes (codp, CPF, nome, sexo, idade, cidade, doença)
VALUES
(1, '12345678901', 'João Silva', 'M', 30, 'São Paulo', 'Hipertensão'),
(2, '23456789012', 'Maria Santos', 'F', 25, 'Rio de Janeiro', 'Dermatite'),
(3, '34567890123', 'Pedro Oliveira', 'M', 40, 'São Paulo', 'Fratura'),
(4, '45678901234', 'Ana Pereira', 'F', 18, 'Rio de Janeiro', 'Febre'),
(5, '56789012345', 'Carlos Souza', 'M', 28, 'São Paulo', 'Gravidez'),
(6, '67890123456', 'Laura Martins', 'F', 35, 'Rio de Janeiro', 'Catarata'),
(7, '78901234567', 'Lucas Costa', 'M', 55, 'São Paulo', 'Enxaqueca'),
(8, '89012345678', 'Camila Lima', 'F', 32, 'Rio de Janeiro', 'Depressão'),
(9, '90123456789', 'André Santos', 'M', 45, 'São Paulo', 'Arritmia'),
(10, '01234567890', 'Mariana Fernandes', 'F', 21, 'Rio de Janeiro', 'Lesão');

-- Dados fictícios para a tabela Consultas
INSERT INTO Consultas (codm, codp, data, hora)
VALUES
(1, 1, '2023-10-31', '10:00:00'),
(2, 2, '2023-11-01', '14:30:00'),
(3, 3, '2023-11-02', '09:15:00'),
(4, 4, '2023-11-03', '11:45:00'),
(5, 5, '2023-11-04', '13:00:00'),
(6, 6, '2023-11-05', '15:30:00'),
(7, 7, '2023-11-06', '10:45:00'),
(8, 8, '2023-11-07', '16:15:00'),
(9, 9, '2023-11-08', '14:00:00'),
(10, 10, '2023-11-09', '12:30:00');

-- Dados fictícios para a tabela Funcionarios
INSERT INTO Funcionarios (codf, CPF, nome, idade, cidade, salario)
VALUES
(1, '12345678901', 'Maria Silva', 28, 'São Paulo', 4500.00),
(2, '23456789012', 'José Santos', 35, 'Rio de Janeiro', 5200.00),
(3, '34567890123', 'Ana Oliveira', 32, 'São Paulo', 4800.00),
(4, '45678901234', 'Paulo Pereira', 30, 'Rio de Janeiro', 4900.00),
(5, '56789012345', 'Carla Souza', 27, 'São Paulo', 4600.00),
(6, '67890123456', 'Ricardo Martins', 33, 'Rio de Janeiro', 5100.00),
(7, '78901234567', 'Mariana Costa', 29, 'São Paulo', 4700.00),
(8, '89012345678', 'Lucas Lima', 37, 'Rio de Janeiro', 5300.00),
(9, '90123456789', 'Cristina Santos', 31, 'São Paulo', 4900.00),
(10, '01234567890', 'Antonio Fernandes', 34, 'Rio de Janeiro', 5200.00);

-- 1)	Buscar a quantidade de médicos por especialidade, ordenados por especialidade.
SELECT especialidade, COUNT(*) as total_medicos 
FROM Medicos 
GROUP BY especialidade
ORDER BY especialidade;

-- 2)	No exercício 2, buscar apenas aquelas especialidades com mais de 1 médico atendente.
SELECT especialidade, COUNT(*) as total_medicos 
FROM Medicos 
GROUP BY especialidade
HAVING COUNT(*) >= 2
ORDER BY especialidade;

-- 3)	Buscar a maior idade de médicos por especialidade.
SELECT especialidade, MAX(idade) as idade_maxima
FROM Medicos
GROUP BY especialidade;

-- 4)	Buscar média de salário dos funcionários por cidade 
SELECT cidade, CAST(AVG(salario) AS DECIMAL(10, 2)) as media_salario
FROM Funcionarios
GROUP BY cidade;

-- 5)	Apresentar a quantidade de consultas por médicos, listando o código do médico e o total de consultas agendadas 
SELECT codm, COUNT(*) as total_consultas
FROM Consultas
GROUP BY codm;

-- 6)	Apresentar os andares que tem capacidade total de leitos superior a 100 
SELECT andar, SUM(capacidade) as capacidade_total
FROM Ambulatorio
GROUP BY andar
HAVING SUM(capacidade) > 100
ORDER BY andar;
