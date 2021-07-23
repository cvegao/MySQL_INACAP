-- Sakila

-- 1. ¿Qué consulta ejecutarías para obtener todos los clientes dentro de city_id = 312? Su consulta debe devolver el nombre, apellido, correo electrónico y dirección del cliente.
SELECT c.first_name, c.last_name, c.email, a.address, ci.city FROM sakila.customer c
INNER JOIN sakila.address a
ON c.address_id = a.address_id
INNER JOIN sakila.city ci
ON a.city_id = ci.city_id
WHERE a.city_id = 312;

-- 2. ¿Qué consulta harías para obtener todas las películas de comedia? Su consulta debe devolver el título de la película, la descripción, el año de estreno, la calificación, 
-- las características especiales y el género (categoría).
SELECT f.title, f.description, f.release_year, f.rating, f.special_features, c.name FROM sakila.film f
INNER JOIN sakila.film_category fl
ON f.film_id = fl.film_id
INNER JOIN sakila.category c
ON fl.category_id = c.category_id
WHERE c.name = 'Comedy';

-- 3. ¿Qué consulta harías para obtener todas las películas unidas por actor_id = 5? Su consulta debe devolver la identificación del actor, el nombre del actor, el título de 
-- la película, la descripción y el año de lanzamiento.
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS 'Name', f.title, f.description, f.release_year FROM sakila.film f
INNER JOIN sakila.film_actor fa
ON f.film_id = fa.film_id
INNER JOIN sakila.actor a
ON fa.actor_id = a.actor_id
WHERE a.actor_id = 5;

-- 4. ¿Qué consulta ejecutaría para obtener todos los clientes en store_id = 1 y dentro de estas ciudades (1, 42, 312 y 459)? Su consulta debe devolver el nombre, apellido, 
-- correo electrónico y dirección del cliente.
SELECT cus.first_name, cus.last_name, cus.email, ad.address FROM sakila.customer cus
INNER JOIN sakila.address ad
ON cus.address_id = ad.address_id
WHERE cus.store_id = 1 AND ad.city_id IN (1, 42, 312, 459);

-- 5. ¿Qué consulta realizarías para obtener todas las películas con una "calificación = G" y "característica especial = detrás de escena", unidas por actor_id = 15? Su 
-- consulta debe devolver el título de la película, la descripción, el año de lanzamiento, la calificación y la función especial. Sugerencia: puede usar la función LIKE 
-- para obtener la parte 'detrás de escena'.
SELECT f.title, f.description, f.release_year, f.rating, f.special_features FROM sakila.film f
INNER JOIN sakila.film_actor fa
ON f.film_id = fa.film_id
WHERE f.rating = 'G' AND LOWER(f.special_features) LIKE '%behind the scene%' AND fa.actor_id = 15;

-- 6. ¿Qué consulta harías para obtener todos los actores que se unieron en el film_id = 369? Su consulta debe devolver film_id, title, actor_id y actor_name.
SELECT fa.film_id, f.title, a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS 'actor_name' FROM sakila.actor a
INNER JOIN sakila.film_actor fa
ON a.actor_id = fa.actor_id
INNER JOIN sakila.film f
ON fa.film_id = f.film_id
WHERE fa.film_id = 369;

-- 7. ¿Qué consulta harías para obtener todas las películas dramáticas con una tarifa de alquiler de 2.99? Su consulta debe devolver el título de la película, 
-- la descripción, el año de estreno, la calificación, las características especiales y el género (categoría).
SELECT f.title, f.description, f.release_year, f.rating, f.special_features, c.name FROM sakila.film f
INNER JOIN sakila.film_category fc
ON f.film_id = fc.film_id
INNER JOIN sakila.category c
ON fc.category_id = c.category_id
WHERE f.rental_rate = 2.99;

-- 8. ¿Qué consulta harías para obtener todas las películas de acción a las que se une SANDRA KILMER? Su consulta debe devolver el título de la película, la 
-- descripción, el año de estreno, la calificación, las características especiales, el género (categoría) y el nombre y apellido del actor.
SELECT f.title, f.description, f.release_year, f.rating, f.special_features, c.name, a.first_name, a.last_name FROM sakila.film f
INNER JOIN sakila.film_category fc
ON f.film_id = fc.film_id
INNER JOIN sakila.category c
ON fc.category_id = c.category_id
INNER JOIN sakila.film_actor fa
ON f.film_id = fa.film_id
INNER JOIN sakila.actor a
ON fa.actor_id = a.actor_id
WHERE UPPER(CONCAT(a.first_name, ' ', a.last_name)) = 'SANDRA KILMER';