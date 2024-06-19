SELECT *, (
    SELECT o.customer_id
    FROM orders o
    WHERE o.id = od.order_id
) AS customer_id
FROM order_details od;

SELECT *
FROM order_details od
WHERE od.order_id IN (
  SELECT order_id
  FROM orders
  WHERE shipper_id = 3
);

SELECT order_id, AVG(quantity) AS avg_quantity
FROM (
  SELECT order_id, quantity
  FROM order_details
  WHERE quantity > 10
) AS temp
GROUP BY order_id;

WITH temp AS (
  SELECT order_id, quantity
  FROM order_details
  WHERE quantity > 10
)
SELECT order_id, AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;
 
 
 DROP FUNCTION IF EXISTS divide;

DELIMITER //

CREATE FUNCTION divide(a FLOAT, b FLOAT) RETURNS FLOAT NO SQL
BEGIN
	RETURN a / b;
END //

DELIMITER ;

SELECT 
    order_id, 
    product_id, 
    divide(quantity, 2) AS divided_quantity
FROM 
    order_details;
