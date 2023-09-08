-- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?--

WITH milk_and_bread AS 
	(
	SELECT
		food_category,
		AVG_price,
		price_value,
		price_unit,
		YEAR,
		average_wages
	FROM t_Aneta_Vonkova_project_SQL_primary-final
	WHERE food_category IN ('Mléko polotučné pasterované','Chléb konzumní kmínový') AND 
		`YEAR` IN (2006, 2018)
	GROUP BY YEAR,
		 food_category
	)
SELECT 
	*,
	ROUND(average_wages/AVG_price, 0) AS available_purchase 
FROM milk_and_bread ;




