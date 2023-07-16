/* 1. ¿Qué consulta ejecutaría para obtener los ingresos totales para marzo de 2012? */

SELECT monthname("2012/03/01") AS mes, SUM(billing.amount) AS totalIngresos
FROM billing
WHERE billing.charged_datetime >= "2012/03/01"
AND billing.charged_datetime <= "2012/03/31";

/* 2. ¿Qué consulta ejecutaría para obtener los ingresos totales 
recaudados del cliente con una identificación de 2? */

SELECT clients.client_id, SUM(billing.amount) as totalGastado
FROM clients JOIN billing ON clients.client_id = billing.client_id
WHERE clients.client_id = "2";

/* 3. ¿Qué consulta ejecutaría para obtener todos los sitios que posee client = 10? */

SELECT sites.domain_name AS sitioWeb, clients.client_id AS client_id
FROM sites JOIN clients ON sites.client_id = clients.client_id
WHERE clients.client_id = "10";

/* 4. ¿Qué consulta ejecutaría para obtener el número total de sitios creados 
por mes por año para el cliente con una identificación de 1? ¿Qué pasa con el cliente = 20? */

SELECT clients.client_id AS client_id, COUNT(site_id) AS cantidadDePaginasWeb,
monthname(created_datetime) AS month_created, year(created_datetime) AS year_created
FROM clients JOIN sites ON sites.client_id = clients.client_id
WHERE clients.client_id = "1" AND sites.created_datetime >= "2010/11/01"
AND sites.created_datetime <= "2013/01/01" 	
GROUP BY month_created, year_created ORDER BY year_created;

SELECT clients.client_id AS client_id, COUNT(site_id) AS cantidadDePaginasWeb,
monthname(created_datetime) AS month_created, year(created_datetime) AS year_created
FROM clients JOIN sites ON sites.client_id = clients.client_id
WHERE clients.client_id = "20" AND sites.created_datetime >= "2010/11/01"
AND sites.created_datetime <= "2013/01/01" 	
GROUP BY month_created, year_created ORDER BY year_created;

/* 5. ¿Qué consulta ejecutaría para obtener el número total de clientes potenciales generados 
para cada uno de los sitios entre el 1 de enero de 2011 y el 15 de febrero de 2011? */

DELETE FROM sites WHERE sites.site_id = "1";

SELECT sites.domain_name AS website, COUNT(leads.leads_id) AS numberOfLeads,
DATE_FORMAT(sites.created_datetime, "%M %d %Y") AS dateGenerated
FROM sites JOIN leads ON leads.site_id = sites.site_id
WHERE leads.registered_datetime > "2011/01/01" AND leads.registered_datetime < "2011/02/15"
GROUP BY website, dateGenerated;

/* 6. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y 
el número total de clientes potenciales que hemos generado para cada uno de nuestros clientes 
entre el 1 de enero de 2011 y el 31 de diciembre de 2011? */

SELECT CONCAT(clients.first_name, " ", clients.last_name) AS client_name, 
COUNT(leads.first_name) AS numberOfLeads 
FROM clients JOIN sites ON sites.client_id = clients.client_id
JOIN leads ON leads.site_id = sites.site_id
WHERE leads.registered_datetime BETWEEN "2011-01-01" AND "2011-12-31"
GROUP BY client_name;

/* 7. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y 
el número total de clientes potenciales que hemos generado para cada cliente 
cada mes entre los meses 1 y 6 del año 2011? */

SELECT CONCAT(clients.first_name, " ", clients.last_name) AS client_name,
COUNT(leads.leads_id) AS numberOfLeads, monthname(leads.registered_datetime) AS month_generated
FROM clients JOIN sites ON sites.client_id = clients.client_id
JOIN leads ON leads.site_id = sites.site_id
WHERE leads.registered_datetime >= "2011/01/01" AND leads.registered_datetime < "2011/07/01"
GROUP BY client_name, month_generated;

/* 8. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y 
el número total de clientes potenciales que hemos generado para cada uno de los 
sitios de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011? 
Solicite esta consulta por ID de cliente. Presente una segunda consulta que muestre 
todos los clientes, los nombres del sitio y el número total de clientes potenciales 
generados en cada sitio en todo momento. */

SELECT CONCAT(clients.first_name, " ", clients.last_name) AS client_name, sites.domain_name AS website,
COUNT(leads.leads_id) AS numberOfLeads, DATE_FORMAT(sites.created_datetime, "%M %d %Y") AS date_generated
FROM clients JOIN sites ON sites.client_id = clients.client_id
JOIN leads ON leads.site_id = sites.site_id
WHERE year(sites.created_datetime) = "2011"
GROUP BY sites.site_id
ORDER BY date_generated DESC;

SELECT CONCAT(clients.first_name, " ", clients.last_name) AS client_name, 
sites.domain_name AS website,
COUNT(leads.leads_id) AS numberOfLeads
FROM clients JOIN sites ON sites.client_id = clients.client_id
JOIN leads ON leads.site_id = sites.site_id
GROUP BY client_name, website
ORDER BY numberOfLeads;

/* 9. Escriba una sola consulta que recupere los ingresos totales recaudados de cada cliente 
para cada mes del año. Pídalo por ID de cliente. */

SELECT CONCAT(clients.first_name, " ", clients.last_name) AS client_name, SUM(billing.amount) AS totalRevenue,
monthname(billing.charged_datetime) AS monthCharge, year(billing.charged_datetime) AS yearCharge
FROM clients JOIN billing ON clients.client_id = billing.client_id
GROUP BY client_name, billing.charged_datetime;

/* 10. Escriba una sola consulta que recupere todos los sitios que posee cada cliente. 
Agrupe los resultados para que cada fila muestre un nuevo cliente. 
Se volverá más claro cuando agregue un nuevo campo llamado 'sitios' que tiene todos 
los sitios que posee el cliente. (SUGERENCIA: use GROUP_CONCAT) */

SELECT CONCAT(clients.first_name, " ", clients.last_name) AS client_name,
GROUP_CONCAT(sites.domain_name) AS sites
FROM clients JOIN sites ON sites.client_id = clients.client_id
GROUP BY clients.first_name, clients.last_name;