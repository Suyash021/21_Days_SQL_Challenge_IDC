/* **Phase 1: Foundation & Inspection**
1. Install IDC_Pizza.dump as IDC_Pizza server */ 

--  List all unique pizza categories (`DISTINCT`).
SELECT DISTINCT category FROM pizza_types; 


-- Display `pizza_type_id`, `name`, and ingredients, replacing NULL ingredients with `"Missing Data"`. Show first 5 rows.
SELECT 
	pizza_type_id,
    name ,
    COALESCE(ingredients, 'No Ingredients') AS Ingredients
FROM pizza_types
LIMIT 5; 


-- Check for pizzas missing a price (`IS NULL`).
SELECT * FROM pizzas
WHERE price IS NULL;



/* **Phase 2: Filtering & Exploration** */
-- 1. Orders placed on `'2015-01-01'` (`SELECT` + `WHERE`).
SELECT 
	order_id,
    date
FROM orders
WHERE date ='2015-01-01';


-- 2. List pizzas with `price` descending.
SELECT * FROM pizzas
ORDER BY price DESC;

-- 3. Pizzas sold in sizes `'L'` or `'XL'`.
SELECT * FROM pizzas
WHERE size = 'L' or size = 'XL';


-- 4. Pizzas priced between $15.00 and $17.00.
SELECT * FROM pizzas
WHERE price BETWEEN 15.00 and 17.00
ORDER BY price;


-- 5. Pizzas with `"Chicken"` in the name.

SELECT * FROM pizza_types
WHERE category = 'Chicken';


-- 6. Orders on `'2015-02-15'` or placed after 8 PM. 
SELECT * FROM orders
WHERE date ='2015-02-15' or time >= '20:00:00'
ORDER BY order_id;



/* **Phase 3: Sales Performance***/ 
-- 1. Total quantity of pizzas sold (`SUM`).
SELECT SUM(quantity) As Total_Pizzas_Sold FROM order_details;


-- 2. Average pizza price (`AVG`).
SELECT ROUND(AVG(price),2) as avg_price FROM pizzas;

-- 3. Total order value per order (`JOIN`, `SUM`, `GROUP BY`). 
SELECT
	o.order_id,
    ROUND(SUM(p.price * o.quantity),2) as Total_order_value
FROM order_details o
INNER JOIN pizzas p
ON o.pizza_id = p.pizza_id
GROUP BY o.order_id;


-- 4. Total quantity sold per pizza category (`JOIN`, `GROUP BY`). 
SELECT 
	DISTINCT pt.category ,
    SUM(o.quantity) as Total_quantity
FROM order_details o
JOIN pizzas p 
ON p.pizza_id = o.pizza_id
JOIN pizza_types pt  
ON  pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category;   


-- 5. Categories with more than 5,000 pizzas sold (`HAVING`).
SELECT 
	DISTINCT pt.category ,
    SUM(o.quantity) as Total_quantity
FROM order_details o
JOIN pizzas p 
ON p.pizza_id = o.pizza_id
JOIN pizza_types pt  
ON  pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category
HAVING SUM(o.quantity) > 5000;

-- 6. Pizzas never ordered (`LEFT/RIGHT JOIN`).
select p.pizza_id,pt.name
from pizzas p
join pizza_types pt
on p.pizza_type_id= pt.pizza_type_id
left join order_details o
on p.pizza_id=o.pizza_id
where o.pizza_id is null;


-- 7. Price differences between different sizes of the same pizza (`SELF JOIN`).
select p1.pizza_type_id,p1.size,p2.size,
round(abs(p1.price-p2.price), 2) as price_difference
from pizzas p1
join pizzas p2
on p1.pizza_type_id= p2.pizza_type_id
where p1.size <> p2.size and p1.size < p2.size
order by price_difference desc;
