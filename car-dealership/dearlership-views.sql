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
