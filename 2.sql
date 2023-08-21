-- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?--

WITH milk_and_bread AS 
(
  (SELECT
	  food_category,
	  AVG_price,
  	price_value,
	  price_unit,
	  YEAR,
	  ROUND(AVG(average_wages),2) AS average_wages
  FROM t_Aneta_Vonkova_project_SQL_primary-final
  GROUP BY YEAR,
		      food_category
  HAVING food_category IN ('Mléko polotučné pasterované','Chléb konzumní kmínový')
  ORDER BY YEAR ASC
  LIMIT 2) 
UNION 
  (SELECT
  	food_category,
	  AVG_price,
	  price_value,
	  price_unit,
	  YEAR,
	  ROUND(AVG(average_wages),2) AS average_wages
  FROM t_Aneta_Vonkova_project_SQL_primary-final
  GROUP BY YEAR,
		       food_category
  HAVING food_category IN ('Mléko polotučné pasterované','Chléb konzumní kmínový')
  ORDER BY YEAR DESC 
  LIMIT 2)
)
SELECT 
	*,
	ROUND(average_wages/AVG_price, 0) AS available_purchase 
FROM milk_and_bread ;


