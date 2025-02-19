CREATE TABLE retail_sales(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(6),
	age INT,
	category VARCHAR(15),
	quantity INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale INT


)

SELECT
	COUNT(*)
FROM retail_sales

SELECT * FROM retail_sales
WHERE 
	age IS NULL OR
	category IS NULL OR
	quantity IS NULL OR
	price_per_unit IS NULL OR
	cogs IS NULL OR
	total_sale IS NULL


DELETE FROM retail_sales
WHERE 
	age IS NULL OR
	category IS NULL OR
	quantity IS NULL OR
	price_per_unit IS NULL OR
	cogs IS NULL OR
	total_sale IS NULL

-- how many sales we have?
SELECT COUNT(*) as total_sales FROM retail_sales

-- how many unique customer we have?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales


-- how many unique category we have?
SELECT COUNT(DISTINCT category) FROM retail_sales


--
SELECT * FROM retail_sales
WHERE 
	sale_date = '2022-11-05'

--
SELECT sum(quantity) as total_qty_sold FROM retail_sales
WHERE 
	category = 'Clothing' 
	AND
	quantity >= 4
	AND
	TO_CHAR(sale_date, 'yyyy-mm') = '2022-11'



SELECT 
	category, SUM(total_sale), sum(quantity) as total_sales
FROM
	retail_sales
GROUP BY 
	category


SELECT 
	Round(AVG(age),2)
FROM
	retail_sales
WHERE
	category = 'Beauty'


SELECT 
	count(*)
FROM
	retail_sales
WHERE
	total_sale > 1000


SELECT 
	category, gender, count(transactions_id) as transaction
FROM
	retail_sales
GROUP BY
	category , gender
ORDER BY 
	category

-- imp for interview

SELECT 
	TO_CHAR(sale_date, 'yyyy-mm'), ROUND(AVG(total_sale)) as Avg_sale
FROM
	retail_sales
GROUP BY
	TO_CHAR(sale_date, 'yyyy-mm')
ORDER BY 
	Avg_sale DESC
LIMIT 5

-- or 
WITH T1 AS
(
	SELECT 
		EXTRACT(YEAR FROM sale_date) as year, 
		EXTRACT(MONTH FROM sale_date) as month , 
		ROUND(AVG(total_sale)) as avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	FROM
		retail_sales
	GROUP BY
	year, month
)

SELECT 
	year,
	month,
	avg_sale
FROM
	T1
WHERE rank = 1

--

SELECT 
	customer_id, 
	SUM(total_sale) as sale
FROM
	retail_sales
GRoUP BY 
	customer_id
ORDER BY
	sale DESC
LIMIT 5

--

SELECT 
	category,
	count(DISTINCT(customer_id))
FROM
	retail_sales
GROUP BY
	category

--
WITH t2 AS
(
	SELECT 
		CASE
			WHEN EXTRACT(HOUR FROM sale_time ) < 12 THEN 'morning'
			WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
			ELSE
				'evening'
			END AS shift,
		Count(transactions_id)
FROM
	retail_sales

GROUP BY 
	shift
)

SELECT * FROM t2
--WHERE shift = 'morning'

--END OF PROJECT 
