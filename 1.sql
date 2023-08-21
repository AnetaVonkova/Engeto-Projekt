-- 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají? -- 

SELECT 
	wage_1.industry,
	wage_1.average_wages,
	wage_2.average_wages AS wages_prev, 
	wage_1.YEAR,
	wage_2.YEAR + 1 AS year_prev,
	wage_1.average_wages - wage_2.average_wages AS wage_growth
FROM t_Aneta_Vonkova_project_SQL_primary_final AS wage_1
JOIN t_Aneta_Vonkova_project_SQL_primary_final AS wage_2
	ON wage_1.industry = wage_2.industry
	AND wage_1.YEAR = wage_2.YEAR + 1
GROUP BY industry,
		 YEAR
HAVING wage_growth < 0
ORDER BY year;