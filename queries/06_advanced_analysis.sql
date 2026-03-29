use sakila;
-- Rank customers based on total spending using window functions

WITH customer_spending AS(
SELECT c.customer_id,
	CONCAT(c.first_name," ",c.last_name) AS name,
	SUM(amount) as total_spending,
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY customer_id
)
SELECT customer_id,
	name,
    total_spending,
    RANK() OVER(ORDER BY total_spending DESC) AS customer_rank
FROM customer_spending
ORDER BY total_spending DESC;

-- Calculate running revenue totals over time.
SELECT payment_date,
	amount,
	SUM(amount) OVER (ORDER BY payment_date) AS running_total
FROM payment
ORDER BY payment_date;

-- Identify the top movie within each category.
WITH movie_revenue AS (
    SELECT 
        c.name AS category,
        f.title,
        SUM(p.amount) as total_amount
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON f.film_id = fc.film_id
    JOIN inventory i ON i.film_id = f.film_id
    JOIN rental r ON r.inventory_id = i.inventory_id
    JOIN payment p ON p.rental_id = r.rental_id
    GROUP BY c.name, f.title
),
ranked_movies AS (
    SELECT 
        category,
        title,
        total_amount,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_amount DESC
        ) AS movie_rank
    FROM movie_revenue
)
SELECT *
FROM ranked_movies
WHERE movie_rank = 1
ORDER BY category;

-- Analyze repeat customer behavior.
# total spending behaviour -- identify total spending per customer
SELECT
	CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    SUM(p.amount) AS total_spending
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY customer_name
ORDER BY total_spending DESC;

# purchase frequency -- no of rentals per customer
SELECT
	CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    COUNT(rental_id) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY customer_name
ORDER BY rental_count DESC;

# last rental date -- Inactive customers
SELECT
	customer_id,
    MAX(rental_date) AS last_rental
FROM rental
GROUP BY customer_id;

# RFM analysis
SELECT
	p.customer_id,
    MAX(r.rental_date) AS last_rental,
	COUNT(r.rental_id) AS rental_count,
    SUM(p.amount) AS total_spending
FROM rental r
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY p.customer_id;

# customer category preference
SELECT
	c.name AS category,
    count(rental_id) AS rental_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY name
ORDER BY rental_count DESC;

# customer lifetime value
SELECT
    customer_id,
    SUM(amount) AS lifetime_value
FROM payment
GROUP BY customer_id
ORDER BY lifetime_value DESC;

# behavior segmentation
SELECT
	customer_id,
    SUM(amount) as total_spent,
CASE
	WHEN SUM(amount) > 150 THEN "High"
    WHEN SUM(amount) > 75 THEN "Medium"
    ELSE "Low"
END AS customer_segment
FROM payment
GROUP BY customer_id;

-- Identify customers with highest rental frequency growth.
WITH rentals_per_month AS (
    SELECT
        customer_id,
        DATE_FORMAT(rental_date, '%Y-%m') AS month,
        COUNT(rental_id) AS monthly_rentals
    FROM rental
    GROUP BY customer_id, month
),
cumulative_rentals AS (
    SELECT
        customer_id,
        month,
        monthly_rentals,
        SUM(monthly_rentals) OVER (
            PARTITION BY customer_id
            ORDER BY month
        ) AS cumulative_rentals
    FROM rentals_per_month
),
rental_growth AS (
    SELECT
        customer_id,
        month,
        cumulative_rentals,
        LAG(cumulative_rentals) OVER (
            PARTITION BY customer_id
            ORDER BY month
        ) AS prev_cumulative,
        cumulative_rentals - LAG(cumulative_rentals) OVER (
            PARTITION BY customer_id
            ORDER BY month
        ) AS monthly_growth
    FROM cumulative_rentals
)
SELECT
    customer_id,
    SUM(monthly_growth) AS total_growth
FROM rental_growth
WHERE monthly_growth IS NOT NULL
GROUP BY customer_id
ORDER BY total_growth DESC
LIMIT 10;
