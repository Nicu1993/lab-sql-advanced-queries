use sakila;

-- 1. Get all pairs of actors that worked together.
SELECT DISTINCT a1.actor_id, a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
                a2.actor_id, a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name
FROM actor a1
JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
WHERE a1.actor_id < a2.actor_id;

-- 2. For each film, list actor that has acted in more films.
SELECT f.film_id, f.title, a.actor_id, a.first_name, a.last_name
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
JOIN (
    SELECT fa.film_id, COUNT(*) AS actor_count
    FROM film_actor fa
    GROUP BY fa.film_id
) AS actor_counts ON f.film_id = actor_counts.film_id
WHERE actor_counts.actor_count = (
    SELECT MAX(actor_count)
    FROM (
        SELECT fa.film_id, COUNT(*) AS actor_count
        FROM film_actor fa
        GROUP BY fa.film_id
    ) AS film_counts
)