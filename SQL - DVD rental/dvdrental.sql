-- DATA MANIPULATION

-- Changing empty cells into NULL
SELECT address_id, address, NULLIF(address2, '') as address2, NULLIF(district, '') as district, city_id, NULLIF(postal_code, '') as postal_code, NULLIF(phone, '') as phone, last_update
FROM address
ORDER BY 1;

-- Updating column with date and time to date only:
SELECT payment_date, DATE(payment_date) as date FROM payment;

ALTER TABLE payment
ADD date_converted DATE;

UPDATE payment
set date_converted = DATE(payment_date);

SELECT * FROM payment;


-- Getting the street number from address:
SELECT split_part(address, ' ',1) as street_number
FROM address;
-- Getting the street name from address:
SELECT REGEXP_SUBSTR(address, ' .*') as street_name
FROM address;

-- Adding columns with street number and street name to the address table:
ALTER TABLE address
ADD street_number2 VARCHAR;

UPDATE address
SET street_number2 = split_part(address, ' ',1);

ALTER TABLE address
ADD street_name VARCHAR;

UPDATE address
SET street_name = REGEXP_SUBSTR(address, ' .*')
SELECT * FROM address;

-- Removing column address2 as it is empty
ALTER TABLE address
DROP COLUMN address2
SELECT * FROM address;

-- Creating column with staff name based on staff_id
SELECT staff_id,
CASE WHEN staff_id = '1' THEN 'Mike'
	WHEN staff_id = '2' THEN 'Jon'
	END AS staff_name
FROM payment;

-- -- -- -- -- -- -- -- -- -- 
-- -- DATA ANALYSIS

-- Counting how many film entries there are
SELECT count(title) 
FROM film;

-- how many actors from list contain 'Julia' in their name?
SELECT COUNT(first_name) FROM actor
WHERE first_name LIKE '%Julia%';

-- What kind of film categories we have?
SELECT name from category;

-- Which film categories are rented most often?
SELECT count(rental.rental_date) AS category_count, category.name
FROM rental
LEFT JOIN inventory
  ON rental.inventory_id = inventory.inventory_id
LEFT JOIN film_category
  ON inventory.film_id = film_category.film_id
LEFT JOIN category
  ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY category_count DESC;


-- Which films earned in total more than 150$?
SELECT film.title, COUNT(payment.payment_id) as rented, SUM(payment.amount) as total_value
FROM payment
LEFT JOIN rental
ON payment.rental_id = rental.rental_id
LEFT JOIN inventory
ON rental.inventory_id = inventory.inventory_id
LEFT JOIN film
ON inventory.film_id = film.film_id
GROUP BY film.title
HAVING SUM(payment.amount) >150
ORDER BY 1;


-- What is mean transaction value per customer?
SELECT customer_id, ROUND(SUM(amount)/COUNT(amount),2) as mean_transaction_value from payment
GROUP BY customer_id
ORDER BY mean_transaction_value DESC;

-- What is max transaction amount by customer?
SELECT customer_id, payment_id, max(amount) as max_transaction_value
FROM payment
GROUP BY customer_id, payment_id
ORDER BY max(amount) DESC;

-- Cummulative earning per staff per month
-- Created as visualisation:
CREATE VIEW Cummulative_earnings as
SELECT EXTRACT(MONTH FROM payment_date) as month, 
	staff_id, payment_id, amount, 
	SUM(amount) OVER (PARTITION BY staff_id, EXTRACT(MONTH FROM payment_date)  ORDER BY payment_date) as cummulative_amount
FROM payment;

-- The above used to calculate the total monthly earnings per staff
WITH cummulative_earnings (month, staff_id, payment_id, amount, cummulative_amount)
as
(
SELECT EXTRACT(MONTH FROM payment_date) as month, 
	staff_id, payment_id, amount, 
	SUM(amount) OVER (PARTITION BY staff_id, EXTRACT(MONTH FROM payment_date)  ORDER BY payment_date) as cummulative_amount
FROM payment
)
SELECT month, staff_id, max(cummulative_amount) FROM cummulative_earnings
GROUP BY month, staff_id
ORDER BY month, staff_id;

-- Creating user login for every customer containing first letter of name, 3 letters of last name and 3 random digits
-- and storing in the temp table
SELECT customer_id, first_name, last_name, LOWER(LEFT(first_name,1)) || LOWER(LEFT(last_name,3)) || FLOOR(random()*1000) as login
INTO TABLE logins
FROM customer
ORDER BY 1;
SELECT * FROM logins;