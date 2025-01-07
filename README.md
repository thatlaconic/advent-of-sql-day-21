# [Santa chooses his influencer](https://adventofsql.com/challenges/21)

## Description
Santa Claus sat at his desk, pondering which influencer to choose for his festive campaign. His efficient elves had compiled a shortlist, but Santa craved a touch more magic in his decision. Inspired by modern analytics, he envisioned using an intricate SQL query to delve into influencer sales trends, akin to evaluating seasonal sales growth. As he pieced together the CTEs and window functions in his head, he saw the story unfold: he needed to find the influencer with the highest sales, reminiscent of the quarter with climbing toy orders. He has his on eye on one influencer in particular but he needs to check their sales momentum is still high.

## Challenge
[Download Challenge data](https://github.com/thatlaconic/advent-of-sql-day-21/blob/main/advent_of_sql_day_21.sql)

+ Find the quarter with the highest growth rate relative to the previous quarter's sales figures
+ Order by growth rate descending

## Dataset
This dataset contains 1 table. 
### Using PostgreSQL
**input**

```sql
SELECT *
FROM sales ;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-21/blob/main/d21_sales.PNG)

### Solution
[Download Solution Code](https://github.com/thatlaconic/advent-of-sql-day-21/blob/main/advent_answer_day21.sql)

**input**
```sql

WITH CTE AS (SELECT DATE_PART('year', sale_date) AS year, DATE_PART('quarter', sale_date) AS quarter, 
				SUM(amount) AS current_sales, 
				LAG(SUM(amount)) OVER(ORDER BY DATE_PART('year', sale_date), DATE_PART('quarter', sale_date) ASC) as previous_sales
			FROM sales
			GROUP BY year, quarter)
	SELECT *, (current_sales - previous_sales) /previous_sales AS growth_rate
	FROM CTE 
	WHERE previous_sales IS NOT NULL
	ORDER BY growth_rate DESC;

```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-21/blob/main/d21.PNG)
