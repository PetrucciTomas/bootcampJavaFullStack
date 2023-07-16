/* 1. ¿Qué consulta harías para obtener todos los países que hablan esloveno? 
Tu consulta debe devolver el nombre del país, el idioma y el porcentaje de idioma. 
Tu consulta debe organizar el resultado por porcentaje de idioma en orden descendente. */

SELECT countries.name, languages.language, languages.percentage
FROM world.countries
JOIN world.languages
ON languages.country_id = countries.id
WHERE languages.language = "Slovene"
ORDER BY percentage DESC;

/* 2. ¿Qué consulta ejecutarías para mostrar el número total de ciudades para cada país? 
Su consulta debe devolver el nombre del país y el número total de ciudades. 
Tu consulta debe organizar el resultado por el número de ciudades en orden descendente. */

SELECT countries.name AS Paises, COUNT(cities.country_id) AS TotalCiudades
FROM countries
JOIN cities
ON cities.country_id = countries.id
GROUP BY countries.name
ORDER BY TotalCiudades DESC;

/* 3. ¿Qué consulta harías para obtener todas las ciudades de México con una población de más de 500,000? 
Tu consulta debe organizar el resultado por población en orden descendente. */

SELECT cities.name AS NombreDeLaCiudad, cities.population AS Poblacion, cities.country_id
FROM countries
JOIN cities
ON cities.country_id = countries.id
WHERE countries.name = "Mexico" AND cities.population >= 500000
ORDER BY cities.population DESC;

/* 4. ¿Qué consulta ejecutarías para obtener todos los idiomas en cada país con un porcentaje superior al 89%? 
Tu consulta debe organizar el resultado por porcentaje en orden descendente. */

SELECT countries.name AS nombre, languages.language AS idioma, languages.percentage as porcentaje
FROM countries
JOIN languages
ON countries.id = languages.country_id
WHERE languages.percentage > 89
ORDER BY porcentaje DESC;

/* 5. ¿Qué consulta haría para obtener todos los países 
con un área de superficie inferior a 501 y una población superior a 100,000? */

SELECT countries.name AS nombre, countries.surface_area as areaDeSuperficie, countries.population as poblacion
FROM countries
WHERE countries.surface_area < 501 AND countries.population > 100000;

/* 6. ¿Qué consulta harías para obtener países con solo 
Monarquía Constitucional con un capital superior a 200 y una esperanza de vida superior a 75 años? */

SELECT countries.name as Paises, countries.government_form as formaDeGobierno, 
countries.capital as capital, countries.life_expectancy as esperanzaDeVida
FROM countries
WHERE countries.government_form = "Constitutional Monarchy" AND countries.capital > 200 
AND countries.life_expectancy > 75;

/* 7. ¿Qué consulta harías para obtener todas las ciudades de Argentina 
dentro del distrito de Buenos Aires y tener una población superior a 500,000? 
La consulta debe devolver el nombre del país, el nombre de la ciudad, el distrito y la población. */

SELECT countries.name AS Pais, 
cities.name AS nombreCiudad, 
cities.district AS distrito, 
cities.population AS poblacion
FROM countries
JOIN cities
ON countries.id = cities.country_id
WHERE cities.district = "Buenos Aires" AND cities.population > 500000;

/* 8. ¿Qué consulta harías para resumir el número de países en cada región? 
La consulta debe mostrar el nombre de la región y el número de países. 
Además, la consulta debe organizar el resultado por el número de países en orden descendente. */

SELECT countries.region AS region, COUNT(countries.name) AS cantidadPaises
FROM countries
GROUP BY countries.region
ORDER BY COUNT(countries.name) DESC;