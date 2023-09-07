CREATE TABLE t_Aneta_Vonkova_project_SQL_primary_final AS
SELECT 
	food.food_category,
	food.AVG_price,
	food.price_value,
 	food.price_unit,
 	food.YEAR,
 	average_wage.industry,
 	average_wage.average_wages,
 	ROUND(e.gdp, 2) AS GDP_in_CR
FROM 
	(SELECT
		cpc.name AS food_category, 
		ROUND(AVG(cp.value),2) AS AVG_price,
		cpc.price_value,
		cpc.price_unit,
		YEAR(cp.date_from) AS YEAR 
	FROM czechia_price AS cp
	JOIN czechia_price_category AS cpc
		ON cp.category_code = cpc.code AND 
		cp.region_code IS NULL
	GROUP BY 
		YEAR(cp.date_from),
		cpc.name
	) AS food 
JOIN 
	(SELECT 
 		cpib.name AS industry, 	
 		ROUND(AVG(cpay.value),2) AS average_wages,
 		cpay.payroll_year AS cpay_YEAR 
	FROM czechia_payroll as cpay
	JOIN czechia_payroll_industry_branch as cpib 
		ON cpay.industry_branch_code = cpib.code
  	WHERE 
		cpay.value_type_code = 5958
 		AND cpay.calculation_code = 100 
  	GROUP BY 
 		cpay.payroll_year,
 		cpib.name
 	) AS average_wage
	ON food.YEAR = average_wage.cpay_YEAR
JOIN economies AS e
	ON e.`year` = average_wage.cpay_YEAR AND 
	e.country = 'Czech Republic';
