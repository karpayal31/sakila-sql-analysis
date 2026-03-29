use sakila;

-- Which store processes the most rentals?
SELECT 
    i.store_id,
    COUNT(r.rental_id) AS count_of_rental
FROM inventory i
JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY i.store_id
ORDER BY count_of_rental DESC
LIMIT 1;

-- Which staff members handle the most transactions?
SELECT 
    s.staff_id,
    s.first_name,
    s.last_name,
    COUNT(p.payment_id) AS transaction_count
FROM staff s
JOIN payment p 
    ON s.staff_id = p.staff_id
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY transaction_count DESC
LIMIT 1;

-- What are the peak rental days or months?
SELECT 
    DATE_FORMAT(rental_date, '%Y-%m') AS month,
    COUNT(rental_id) AS rental_count
FROM rental
GROUP BY month
ORDER BY month;

-- What is the average rental duration before return?
SELECT 
    AVG(DATEDIFF(return_date, rental_date)) 
        AS avg_rental_duration
FROM rental
WHERE return_date IS NOT NULL;

-- Which store has the highest customer activity?
SELECT 
    i.store_id,
    COUNT(DISTINCT r.customer_id) AS customer_count
FROM inventory i
JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY i.store_id
ORDER BY customer_count DESC
LIMIT 1;

