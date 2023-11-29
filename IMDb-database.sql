-- 1) quantos filmes existem?
SELECT COUNT(*) FROM facts_movie

-- 2) quantos filmes existem com o ator "Tom Cruise"?
SELECT COUNT(*) as Filmes
FROM dim_atuam a Inner Join dim_names n ON a.id_names=n.id_names
Where n.actor='Tom Cruise'

-- 3) Quais s�o os filmes com o ator "Tom Cruise" com ano ?
SELECT m.movie_title as titulo, m.title_year as Ano
FROM dim_atuam a Inner Join dim_names n ON a.id_names=n.id_names
     INNER JOIN facts_movie m ON m.id_title=a.id_title
Where n.actor='Tom Cruise'
order by Ano

-- 4) Qual o filme mais popular 
SELECT  m.title_year as Ano, MAX(s.num_voted_users) AS Popularidade
FROM facts_movie m INNER JOIN facts_score s 
     ON m.id_title=s.id_title
Where m.title_year is not Null
GROUP BY m.title_year
Order by Ano

-- 5) Qual o filme mais popular por ano
Select m.movie_title, s.num_voted_users, m.title_year
FROM facts_movie m JOIN facts_score s on m.id_title=s.id_title
Where s.num_voted_users = 
(SELECT max(s.num_voted_users) FROM facts_movie m1 JOIN facts_score s 
                                    on m1.id_title=s.id_title
 where m1.title_year = m.title_year )
 order by m.title_year
