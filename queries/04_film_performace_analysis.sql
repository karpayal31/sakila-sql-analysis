
-- Which movies are rented most frequently?
SELECT f.title,
	COUNT(rental_id) AS rental_count
FROM film f
JOIN inventory i 
	ON f.film_id = i.film_id
JOIN rental r 
	ON i.inventory_id = r.inventory_id
GROUP BY title
ORDER BY rental_count DESC
LIMIT 10;

-- Which movies are least rented?
SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
LEFT JOIN inventory i 
    ON f.film_id = i.film_id
LEFT JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count ASC
LIMIT 10;

-- Which film categories are most popular?
SELECT 
    c.name AS film_category,
    COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc 
    ON c.category_id = fc.category_id
JOIN inventory i 
    ON fc.film_id = i.film_id
JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY total_rentals DESC
LIMIT 5;

-- What is the average rental duration for films?
SELECT 
    AVG(DATEDIFF(return_date, rental_date)) AS avg_actual_rental_days
FROM rental
WHERE return_date IS NOT NULL;

-- Which films generate the highest revenue?
SELECT 
    f.title,
    COUNT(r.rental_id) AS rentals,
    SUM(p.amount) AS revenue
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY f.title
ORDER BY revenue DESC
LIMIT 10;