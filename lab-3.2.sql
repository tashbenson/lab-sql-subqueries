USE sakila;

-- 1 How many copies of the film Hunchback Impossible exist in the inventory system? --
SELECT f.title, COUNT(i.film_id) AS num_films
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
WHERE title = 'Hunchback Impossible'
GROUP BY f.title;

-- 2 List all films whose length is longer than the average of all the films.
SELECT *FROM film
WHERE length> (
	SELECT AVG(length)
    FROM film
);

-- 3 Use subqueries to display all actors who appear in the film Alone Trip.
SELECT * FROM (
  SELECT a.first_name, a.last_name
  FROM actor AS a
  JOIN film_actor AS fa
  ON a.actor_id = fa.actor_id
  JOIN film AS f
  ON fa.film_id = f.film_id
  WHERE f.title = 'Alone Trip'
) as sub1
;

-- 4 Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT * FROM (
	SELECT f.title, c.name
    FROM category AS c
    JOIN film_category AS fc
    ON c.category_id = fc.category_id
    JOIN film AS f
    ON fc.film_id = f.film_id
    WHERE c.name = 'Family'
) as sub1
;

-- 5 Get name and email from customers from Canada using subqueries. Do the same with joins. 
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information

SELECT * FROM (
	SELECT c.first_name, c.last_name, c.email
    FROM country AS cr
	JOIN city AS ct
    ON cr.country_id = ct.country_id
    JOIN address AS A
    ON ct.city_id = a.city_id
    JOIN customer AS c
    ON a.address_id = c.address_id
    WHERE country = 'Canada'
) AS sub1;

SELECT c.first_name, c.last_name, c.email
    FROM country AS cr
	JOIN city AS ct
    ON cr.country_id = ct.country_id
    JOIN address AS A
    ON ct.city_id = a.city_id
    JOIN customer AS c
    ON a.address_id = c.address_id
    WHERE country = 'Canada';

-- 6 Which are films starred by the most prolific actor? 
SELECT a.actor_id, a.first_name,a.last_name, 
count(fc.film_id) AS num_films
FROM actor AS a
JOIN film_actor AS fc
ON a.actor_id = fc.actor_id
GROUP BY  a.actor_id, a.first_name,a.last_name
HAVING num_films > 1
ORDER BY num_films DESC;
-- Gina Degeneres most prolific actor with actor_id 107

SELECT * FROM(
	SELECT f.title
    FROM film AS f
    JOIN film_actor AS fa
    ON f.film_id = fa.film_id
    WHERE fa.actor_id = '107'
) AS sub1;

-- 7 Films rented by most profitable customer. 
-- You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

SELECT c.first_name, c.last_name, p.customer_id, SUM(amount)
FROM customer AS c
JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name, p.customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;
-- customer_id is 526
        
SELECT * FROM(
	SELECT title
    FROM film AS f
    JOIN inventory AS i
    ON f.film_id = i.film_id
    JOIN rental AS r
    ON i.inventory_id = r.inventory_id
    WHERE customer_id = '526'
) as sub1
;

-- 8 Customers who spent more than the average payments.
SELECT customer_id FROM(
	SELECT * FROM payment
	WHERE amount > (
	SELECT AVG(amount) FROM payment) 
    ) AS sub2
GROUP BY customer_id
;

