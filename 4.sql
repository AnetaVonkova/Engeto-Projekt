-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? --

WITH price_and_wage AS
(
	SELECT 
		AVG(price1.AVG_price) AS price,
		price1.YEAR,
		AVG(price2.AVG_price) AS price_prev,
		price2.YEAR+1 AS YEAR_prev,
		(AVG(price1.AVG_price) - AVG(price2.AVG_price))/AVG(price2.AVG_price)*100 AS price_growth_per_years,
		AVG(price1.average_wages) AS wages,
		AVG(price2.average_wages) AS wages_prev, 
		(AVG(price1.average_wages) - AVG(price2.average_wages))/AVG(price2.average_wages)*100 AS wage_growth_per_year
	FROM t_Aneta_Vonkova_project_SQL_primary_final AS price1
	JOIN t_Aneta_Vonkova_project_SQL_primary_final AS price2
		ON price1.food_category = price2.food_category AND 
		price1.YEAR = price2.YEAR + 1 AND 
		price1.industry = price2.industry
	GROUP BY YEAR
)
SELECT 
	YEAR,
	ROUND(price_growth_per_years - wage_growth_per_year, 2) AS compare
FROM price_and_wage 
WHERE price_growth_per_years > wage_growth_per_year ;





