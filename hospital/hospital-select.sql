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
