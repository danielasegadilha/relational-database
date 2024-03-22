CREATE TABLE Horario (
codm INTEGER PRIMARY KEY,
DiaSemana INT CHECK (DiaSemana BETWEEN 1 AND 7)
FOREIGN KEY (codm) REFERENCES Medicos(codm),
)
  
-- 1 listar nome e doença dos funcionários que são pacientes
SELECT p.nome as Paciente, p.doença
FROM Pacientes p JOIN Funcionarios f ON p.nome = f.nome

-- 2 Listar médicos e suas especialidades que trabalham no domingo
SELECT m.nome as Medicos, m.especialidade
FROM Medicos m JOIN Horario h ON m.codm = h.codm 
WHERE h.DiaSemana = 1

-- 3 Quais especialidades estão disponíveis na 2a feira
SELECT m.especialidade
FROM Medicos m JOIN Horario h ON m.codm = h.codm 
WHERE h.DiaSemana = 2

-- 4 Quantos médicos trabalham por dia de semana
SELECT 
  CASE
    WHEN h.DiaSemana = 1 THEN 'Domingo'
    WHEN h.DiaSemana = 2 THEN 'Segunda-feira'
    WHEN h.DiaSemana = 3 THEN 'Terça-feira'
    WHEN h.DiaSemana = 4 THEN 'Quarta-feira'
    WHEN h.DiaSemana = 5 THEN 'Quinta-feira'
    WHEN h.DiaSemana = 6 THEN 'Sexta-feira'
    ELSE 'Desconhecido'
  END AS DiaSemana,
  COUNT(*) AS QuantidadeDeMedicos
FROM Medicos m
JOIN Horario h ON m.codm = h.codm
GROUP BY DiaSemana;

-- 5 Quais dias da semana o hospital dispõe de Oftalmologistas
SELECT h.DiaSemana as Dia
FROM Horario h JOIN Medicos m ON h.codm = m.codm 
WHERE m.especialidade = 'Oftalmologia'

-- 6 Quantos médicos ortopedistas trabalham por dia de semana
SELECT 
  CASE
    WHEN h.DiaSemana = 1 THEN 'Domingo'
    WHEN h.DiaSemana = 2 THEN 'Segunda-feira'
    WHEN h.DiaSemana = 3 THEN 'Terça-feira'
    WHEN h.DiaSemana = 4 THEN 'Quarta-feira'
    WHEN h.DiaSemana = 5 THEN 'Quinta-feira'
    WHEN h.DiaSemana = 6 THEN 'Sexta-feira'
    ELSE 'Desconhecido'
  END AS DiaSemana,
  COUNT(*) AS QuantidadeDeMedicosOrtopedistas
FROM Medicos m
JOIN Horario h ON m.codm = h.codm
WHERE m.especialidade = 'Ortopedia'
GROUP BY DiaSemana;
