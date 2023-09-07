-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? -- 

WITH growth AS 
	(SELECT 
		price1.food_category,
		price1.AVG_price,
		price1.YEAR,
		price2.YEAR + 1 AS YEAR_prev,
		price2.AVG_price AS price_prev,
		ROUND((price1.AVG_price - price2.AVG_price)/price2.AVG_price*100, 2) AS price_growth
	FROM t_Aneta_Vonkova_project_SQL_primary_final AS price1
	JOIN t_Aneta_Vonkova_project_SQL_primary_final AS price2
		ON price1.food_category = price2.food_category AND 
		price1.YEAR = price2.YEAR + 1
  	GROUP BY food_category,
		YEAR)
SELECT 
	food_category, 
	SUM(price_growth) AS slow_price_increas
FROM growth 
GROUP BY food_category 
HAVING slow_price_increas > 0
ORDER BY slow_price_increas
LIMIT 1;





