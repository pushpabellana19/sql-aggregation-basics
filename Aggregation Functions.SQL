Question 1: Freight by Country

Question: Find the top 5 countries with the highest total freight.

SELECT
    ship_country AS country,
    ROUND(SUM(freight)::numeric, 2) AS total_freight
FROM orders
GROUP BY ship_country
ORDER BY total_freight DESC, country
LIMIT 5;


QUESTION 2: BUSY CUSTOMERS

Question: Find customers with more than 20 orders.

SELECT
    c.company_name,
    COUNT(o.order_id) AS orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.company_name
HAVING COUNT(o.order_id) > 20
ORDER BY orders DESC, c.company_name ASC;


QUESTION 3: AVERAGE PRICE PER CATEGORY

Question: Find the average unit price of products in each category.

SELECT
    c.category_name,
    ROUND(AVG(p.unit_price)::numeric, 2) AS average_price
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_name ASC;


QUESTION 4: TOP FIVE EMPLOYEES

Question: Find the five employees who handled the most orders.

SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee,
    COUNT(o.order_id) AS orders
FROM employees e
JOIN orders o
    ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY orders DESC, employee ASC
LIMIT 5;


QUESTION 5: ORDERS PER YEAR

Question: Find the number of orders placed in each calendar year.

SELECT
    EXTRACT(YEAR FROM order_date)::integer AS year,
    COUNT(order_id) AS orders
FROM orders
GROUP BY year
ORDER BY year ASC;


QUESTION 6: CONCENTRATED MARKETS

Question: Find countries with more than five customers.

SELECT
    country,
    COUNT(customer_id) AS customers
FROM customers
GROUP BY country
HAVING COUNT(customer_id) > 5
ORDER BY customers DESC, country ASC;


QUESTION 7: FREIGHT STATISTICS

Question: Find the minimum, maximum, average and total freight across all orders.

SELECT
    ROUND(MIN(freight)::numeric, 2) AS min_freight,
    ROUND(MAX(freight)::numeric, 2) AS max_freight,
    ROUND(AVG(freight)::numeric, 2) AS avg_freight,
    ROUND(SUM(freight)::numeric, 2) AS total_freight
FROM orders;


QUESTION 8: BUSY SHIPPING COUNTRIES

Question: Find shipping countries with at least 30 orders.

SELECT
    ship_country,
    COUNT(order_id) AS orders
FROM orders
GROUP BY ship_country
HAVING COUNT(order_id) >= 30
ORDER BY orders DESC, ship_country ASC;

QUESTION 9: LOYAL IN BOTH YEARS

Question: Find customers with at least 5 orders in both 1996 and 1997.

SELECT
    c.company_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.company_name
HAVING
    COUNT(o.order_id) FILTER (
        WHERE EXTRACT(YEAR FROM o.order_date) = 1996
    ) >= 5
    AND
    COUNT(o.order_id) FILTER (
        WHERE EXTRACT(YEAR FROM o.order_date) = 1997
    ) >= 5
ORDER BY c.company_name ASC;


QUESTION 10: CUSTOMERS WITH HIGH FREIGHT

Question: Find customers whose total freight exceeds 500.

SELECT
    c.company_name,
    ROUND(SUM(o.freight)::numeric, 2) AS total_freight
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.company_name
HAVING SUM(o.freight) > 500
ORDER BY total_freight DESC, c.company_name ASC;


QUESTION 11: ACTIVE VS DISCONTINUED

Question: Count active and discontinued products in each category.

SELECT
    c.category_name,
    COUNT(CASE WHEN p.discontinued = 0 THEN 1 END) AS active,
    COUNT(CASE WHEN p.discontinued = 1 THEN 1 END) AS discontinued
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_name ASC;


Q12 – Customer country share

SELECT
    country,
    COUNT(customer_id) AS customers,
    ROUND(
        COUNT(customer_id) * 100.0 / SUM(COUNT(customer_id)) OVER (),
        2
    ) AS pct
FROM customers
GROUP BY country
ORDER BY customers DESC, country ASC;