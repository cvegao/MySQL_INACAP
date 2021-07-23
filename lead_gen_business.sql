-- EVALUACION SQL CONSTANZA VEGA
-- 1. ¿Qué consulta ejecutaría para obtener los ingresos totales para marzo de 2012?
SELECT MONTHNAME(charged_datetime) AS 'month', SUM(amount) AS 'revenue' 
FROM lead_gen_business.billing
WHERE MONTH(charged_datetime) = '3' AND YEAR(charged_datetime) = '2012'
GROUP BY MONTHNAME(charged_datetime);

-- 2. ¿Qué consulta ejecutaría para obtener los ingresos totales recaudados del cliente con una 
-- identificación de 2?
SELECT client_id, SUM(amount) AS 'total_revenue' FROM lead_gen_business.billing
WHERE client_id = 2;

-- 3. ¿Qué consulta ejecutaría para obtener todos los sitios que posee client = 10?
SELECT domain_name AS 'website', client_id FROM lead_gen_business.sites
WHERE client_id = 10;

-- 4. ¿Qué consulta ejecutaría para obtener el número total de sitios creados por mes por año para el 
-- cliente con una identificación de 1? ¿Qué pasa con el cliente = 20?
SELECT client_id, 
COUNT(domain_name) AS 'number_of_websites', 
MONTHNAME(created_datetime) AS 'month_created',
YEAR(created_datetime) AS 'year_created'
FROM lead_gen_business.sites
WHERE client_id = 1
GROUP BY MONTHNAME(created_datetime), YEAR(created_datetime);

SELECT client_id, 
COUNT(domain_name) AS 'number_of_websites', 
MONTHNAME(created_datetime) AS 'month_created',
YEAR(created_datetime) AS 'year_created'
FROM lead_gen_business.sites
WHERE client_id = 20
GROUP BY MONTHNAME(created_datetime), YEAR(created_datetime);

-- 5. ¿Qué consulta ejecutaría para obtener el número total de clientes potenciales generados para cada 
-- uno de los sitios entre el 1 de enero de 2011 y el 15 de febrero de 2011?
SELECT s.domain_name AS 'website', 
COUNT(l.site_id) AS 'number_of_leads',
DATE_FORMAT(l.registered_datetime, '%M %d, %Y') AS 'date_generated'
FROM lead_gen_business.leads l
INNER JOIN lead_gen_business.sites s
ON l.site_id = s.site_id
WHERE l.registered_datetime BETWEEN '2011-01-01' AND '2011-02-15'
GROUP BY DATE_FORMAT(l.registered_datetime, '%M %d, %Y'), l.site_id;

-- 6. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de 
-- clientes potenciales que hemos generado para cada uno de nuestros clientes entre el 1 de enero 
-- de 2011 y el 31 de diciembre de 2011?
SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'client_name',
COUNT(l.leads_id) AS 'number_of_leads'
FROM lead_gen_business.clients c
INNER JOIN lead_gen_business.sites s
ON c.client_id = s.client_id
INNER JOIN lead_gen_business.leads l
ON s.site_id = l.site_id
WHERE l.registered_datetime BETWEEN '2011-01-01' AND '2011-12-31'
GROUP BY c.client_id
ORDER BY c.client_id;

-- 7. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de 
-- clientes potenciales que hemos generado para cada cliente cada mes entre los meses 1 y 6 del año 2011?
SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'client_name',
COUNT(l.leads_id) AS 'number_of_leads',
MONTHNAME(l.registered_datetime) AS 'month_generated'
FROM lead_gen_business.clients c
INNER JOIN lead_gen_business.sites s
ON c.client_id = s.client_id
INNER JOIN lead_gen_business.leads l
ON s.site_id = l.site_id
WHERE l.registered_datetime BETWEEN '2011-01-01' AND '2011-6-30'
GROUP BY c.client_id, MONTHNAME(l.registered_datetime)
ORDER BY MONTH('month_generated');

-- 8. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de 
-- clientes potenciales que hemos generado para cada uno de los sitios de nuestros clientes entre 
-- el 1 de enero de 2011 y el 31 de diciembre de 2011? Solicite esta consulta por ID de cliente. 
-- Presente una segunda consulta que muestre todos los clientes, los nombres del sitio y el número 
-- total de clientes potenciales generados en cada sitio en todo momento.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'client_name',
s.domain_name AS 'website',
COUNT(l.leads_id) AS 'number_of_leads'
FROM lead_gen_business.clients c
INNER JOIN lead_gen_business.sites s
ON c.client_id = s.client_id
INNER JOIN lead_gen_business.leads l
ON s.site_id = l.site_id
WHERE l.registered_datetime BETWEEN '2011-01-01' AND '2011-12-31'
GROUP BY c.client_id, s.domain_name
ORDER BY c.client_id;

SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'client_name',
s.domain_name AS 'website',
COUNT(l.leads_id) AS 'number_of_leads'
FROM lead_gen_business.clients c
INNER JOIN lead_gen_business.sites s
ON c.client_id = s.client_id
INNER JOIN lead_gen_business.leads l
ON s.site_id = l.site_id
GROUP BY c.client_id, s.domain_name
ORDER BY c.client_id;

-- 9. Escriba una sola consulta que recupere los ingresos totales recaudados de cada cliente 
-- para cada mes del año. Pídalo por ID de cliente.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'client_name',
SUM(b.amount) AS 'Total_Revenue',
MONTHNAME(b.charged_datetime) AS 'month_charge',
YEAR(b.charged_datetime) AS 'year_charge'
FROM lead_gen_business.clients c
INNER JOIN lead_gen_business.billing b
ON c.client_id = b.client_id
GROUP BY c.client_id, MONTHNAME(b.charged_datetime), YEAR(b.charged_datetime)
ORDER BY c.client_id, YEAR(b.charged_datetime), MONTHNAME(b.charged_datetime);


-- 10. Escriba una sola consulta que recupere todos los sitios que posee cada cliente. Agrupe 
-- los resultados para que cada fila muestre un nuevo cliente. Se volverá más claro cuando 
-- agregue un nuevo campo llamado 'sitios' que tiene todos los sitios que posee el cliente. 
-- (SUGERENCIA: use GROUP_CONCAT)
SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'client_name',
GROUP_CONCAT(s.domain_name SEPARATOR ' / ') AS 'sites'
FROM lead_gen_business.clients c
INNER JOIN lead_gen_business.sites s
ON c.client_id = s.client_id
GROUP BY c.client_id
ORDER BY c.client_id;