-- 1)	Crie um procedimento armazenado que selecione e liste os pacientes com determinada doença (passada como parâmetro) 
CREATE PROCEDURE Pacient_diasese(@p1 AS VARCHAR(45))
AS
SELECT
	Pacientes.nome
FROM
	Pacientes
WHERE doença = @p1

-- 2)	Crie uma função que calcule o cubo de um numero X
CREATE FUNCTION Cubic(@X INT)
RETURNS INT
BEGIN
	RETURN @X*@X*@X
END

SELECT dbo.Cubic(3)

-- 3)	Crie uma função que calcule a raiz de uma equação do primeiro grau do tipo Ax+B=0, dados os coeficientes A e B (dica x=-B/A)
CREATE FUNCTION Root_equation(@a INT, @b INT)
RETURNS INT
BEGIN
	RETURN -@B/@A
END

DROP FUNCTION Root_equation

CREATE FUNCTION Root_equation(@a DECIMAL(10, 2), @b DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
BEGIN
	RETURN -@B/@A
END

-- 4)	Crie uma função chamada ConsultasApos que retorne as consultas com data posterior a um parâmetro passado (teste com ‘01/10/2020’)
CREATE FUNCTION Consultas_apos(@parameter_date DATE)
RETURNS TABLE
AS
RETURN
(
		SELECT 
			*
		FROM
			Consultas
		WHERE Consultas.data > @parameter_date
);

SELECT * FROM Consultas_apos('2020-10-01')

-- 5)	Criar uma trigger que se cadastrar um novo paciente verifique se o mesmo é do grupo de risco (‘Diabetes’, ‘Hipertensão’, Zica’) e caso seja, o registre na tabela GrpRisco (dica: utilize a função do SQL GETDATE() para obter a data/hora do registro para o campo ‘data’)
CREATE TRIGGER VerificarGrupoRisco
ON Pacientes
AFTER INSERT
AS
BEGIN
    DECLARE @data_registro DATETIME = GETDATE();
    
    INSERT INTO GrpRisco (id_paciente, data)
    SELECT
		Pacientes.codp,
		Consultas.data
    FROM 
		Pacientes
	JOIN
		Consultas ON Pacientes.codp = Consultas.codp
    WHERE
		doença IN ('Diabetes', 'Hipertensão', 'Zica');
END;
