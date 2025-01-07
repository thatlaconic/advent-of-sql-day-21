WITH CTE AS (SELECT DATE_PART('year', sale_date) AS year, DATE_PART('quarter', sale_date) AS quarter, 
				SUM(amount) AS current_sales, 
				LAG(SUM(amount)) OVER(ORDER BY DATE_PART('year', sale_date), DATE_PART('quarter', sale_date) ASC) as previous_sales
			FROM sales
			GROUP BY year, quarter)
	SELECT *, (current_sales - previous_sales) /previous_sales AS growth_rate
	FROM CTE 
	WHERE previous_sales IS NOT NULL
	ORDER BY growth_rate DESC;