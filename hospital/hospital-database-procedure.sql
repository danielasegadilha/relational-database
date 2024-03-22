-- 1) Escreva “Bem-vindo a UC banco de dados II”
CREATE PROCEDURE Welcome 
AS 
BEGIN
	PRINT 'Welcome to database II'
END;

EXEC Welcome

-- 2) Liste os médicos que moram no RJ
CREATE PROCEDURE List_doctor_rj
AS
SELECT 
	Nome, 
	Cidade
FROM
	Medicos
WHERE Cidade = 'Rio de Janeiro'

ALTER PROCEDURE List_doctor_rj
AS
SELECT 
	Nome
FROM
	Medicos
WHERE Cidade = 'Rio de Janeiro'

EXEC List_doctor_rj


-- 3) Dado CPF, liste as informações de um paciente
CREATE PROCEDURE Pacient_info(@p1 AS VARCHAR(11))
AS
SELECT 
	*
FROM
	Pacientes
WHERE CPF = @p1

EXEC Pacient_info '12345678901'

