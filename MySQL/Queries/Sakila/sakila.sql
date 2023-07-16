/* 1. ¿Qué consulta ejecutarías para obtener todos los 
clientes dentro de city_id = 312? Su consulta debe devolver el nombre, apellido, 
correo electrónico y dirección del cliente. */ 

SELECT customer.first_name AS nombre, customer.last_name AS apellido, 
customer.email AS email, address.address AS direccion
FROM customer 
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
WHERE city.city_id = "312";

/* 2. ¿Qué consulta harías para obtener todas las películas de comedia? 
Su consulta debe devolver el título de la película, la descripción, el año de estreno, 
la calificación, las características especiales y el género (categoría). */

SELECT film.title AS titulo, film.description AS descripcion, film.release_year AS añoDeSalida, 
film.rating AS calificacion, film.special_features AS caracteristicasEspeciales, category.name AS genero
FROM film JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "Comedy";

/* 3. ¿Qué consulta harías para obtener todas las películas unidas por actor_id = 5? 
Su consulta debe devolver la identificación del actor, el nombre del actor, 
el título de la película, la descripción y el año de lanzamiento. */

SELECT actor.actor_id, CONCAT(actor.first_name, " ", actor.last_name) AS nombreCompleto,
film.title, film.description, film.release_year
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE actor.actor_id = 5;

/* 4. ¿Qué consulta ejecutaría para obtener todos los clientes en store_id = 1 
y dentro de estas ciudades (1, 42, 312 y 459)? Su consulta debe devolver el nombre, 
apellido, correo electrónico y dirección del cliente. */

SELECT store.store_id, city.city_id, customer.first_name AS nombre, customer.last_name AS apellido, 
customer.email, address.address
FROM store JOIN customer ON customer.store_id = store.store_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
WHERE store.store_id = "1" AND city.city_id IN (1, 42, 312, 459);

/* 5. ¿Qué consulta realizarías para obtener todas las películas con una "calificación = G"
y "característica especial = detrás de escena", unidas por actor_id = 15? 
Su consulta debe devolver el título de la película, la descripción, el año de lanzamiento, 
la calificación y la función especial. 
Sugerencia: puede usar la función LIKE para obtener la parte 'detrás de escena'. */

SELECT film.title AS titulo, film.description AS descripcion, film.release_year AS añoDeSalida,
film.rating AS calificacion, film.special_features AS funcionesEspeciales
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.actor_id = 15 AND film.rating = "G" AND film.special_features LIKE "%Behind the Scenes%";

/* 6. ¿Qué consulta harías para obtener todos los actores que se unieron en el film_id = 369? 
Su consulta debe devolver film_id, title, actor_id y actor_name. */

SELECT film.film_id AS film_id, film.title AS titulo, 
actor.actor_id AS actor_id, CONCAT(actor.first_name, " ", actor.last_name) AS actor_name
FROM film JOIN film_actor ON film_actor.film_id = film.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.film_id = 369;

/* 7. ¿Qué consulta harías para obtener todas las películas dramáticas con una 
tarifa de alquiler de 2.99? Su consulta debe devolver el título de la película, 
la descripción, el año de estreno, la calificación, las características especiales y el género (categoría). */

SELECT film.title AS titulo, film.description AS descripcion, film.release_year AS añoDeSalida,
film.rating AS calificacion, film.special_features AS caracteristicasEspeciales, category.name AS genero, 
film.rental_rate
FROM film JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "Drama" AND film.rental_rate = 2.99 ;

/* 8. ¿Qué consulta harías para obtener todas las películas de acción a las que se une SANDRA KILMER? 
Su consulta debe devolver el título de la película, la descripción, el año de estreno, 
la calificación, las características especiales, el género (categoría) y el nombre y apellido del actor.*/

SELECT actor.actor_id, CONCAT(actor.first_name, " ", actor.last_name) AS actor_name, film.film_id ,film.title AS titulo, 
film.description AS descripcion, film.release_year AS añoDeSalida, film.rating AS calificacion, 
film.special_features AS caracteristicasEspeciales, category.name AS genero
FROM actor JOIN film_actor ON film_actor.actor_id = actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE actor.actor_id = 23 AND category.name = "Action";