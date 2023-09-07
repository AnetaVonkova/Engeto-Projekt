CREATE TABLE t_Aneta_Vonkova_project_SQL_secondary_final AS 
SELECT 
	e.country,
	e.`year`,
	e.gdp,
	e.gini,
	c.population 
FROM economies as e 
JOIN countries as c 
ON e.country = c.country
WHERE `year` IN 
	(SELECT `year` 
	 FROM t_Aneta_Vonkova_project_SQL_primary_final)  
;
