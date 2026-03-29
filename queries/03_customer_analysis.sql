
-- Who are the top 10 customers by total spending?
SELECT c.customer_id, 
	c.first_name, 
    c.last_name, 
    SUM(p.amount) as total_spending
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_spending desc
LIMIT 10;

-- Which customers rent movies most frequently?
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS freq_rental_customer
FROM customer c
JOIN rental r
    ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY freq_rental_customer DESC
LIMIT 5;

-- What is the average spending per customer?
SELECT c.customer_id, 
	c.first_name, 
    c.last_name, 
    AVG(p.amount) as avg_spending
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY avg_spending desc;

-- Are there customers who never rented any movies?
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN rental r
    ON c.customer_id = r.customer_id
WHERE r.customer_id IS NULL;

-- What percentage of revenue comes from top customers?
SELECT c.customer_id, 
	c.first_name, 
    c.last_name, 
    SUM(p.amount) as total_spending,
	ROUND(
		SUM(p.amount) * 100 /
        (SELECT SUM(amount) FROM payment),2
        ) AS revenue_percentage
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_spending desc
LIMIT 10;