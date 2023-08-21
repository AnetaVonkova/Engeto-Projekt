-- Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem? --


SELECT 
	AVG(price1.AVG_price) AS price,
	price1.YEAR,
	AVG(price2.AVG_price) AS price_prev,
	price2.YEAR+1 AS YEAR_prev,
	ROUND((AVG(price1.AVG_price) - AVG(price2.AVG_price))/AVG(price2.AVG_price)*100, 2) AS price_growth_per_years,
	AVG(price1.average_wages) AS wages,
	AVG(price2.average_wages) AS wages_prev, 
	ROUND((AVG(price1.average_wages) - AVG(price2.average_wages))/AVG(price2.average_wages)*100, 2) AS wage_growth_per_year,
	ROUND((price1.GDP_in_CR - price2.GDP_in_CR)/price2.GDP_in_CR*100, 2)  AS GPD_growth
FROM t_Aneta_Vonkova_project_SQL_primary_final AS price1
JOIN t_Aneta_Vonkova_project_SQL_primary_final AS price2
	ON price1.food_category = price2.food_category
	AND price1.YEAR = price2.YEAR + 1
	AND price1.industry = price2.industry
GROUP BY YEAR;





