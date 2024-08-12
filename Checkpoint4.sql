/*Question1 Implement the provided relation model using SQL ( DDL part )*/
CREATE TABLE customertable(
			customer_id INT PRIMARY KEY NOT NULL,
			customer_name VARCHAR (100) NOT NULL,
			customer_tel VARCHAR (30) NOT NULL
			);

CREATE TABLE producttable(
			product_id INT PRIMARY KEY,
			product_name VARCHAR (100) NOT NULL,
			category VARCHAR (50) NOT NULL,
			price FLOAT NOT NULL,
			);

CREATE TABLE ordertable(
			order_id INT PRIMARY KEY,
			customer_id INT FOREIGN KEY(customer_id) REFERENCES customertable(customer_id),
			product_id INT FOREIGN KEY(product_id) REFERENCES producttable(product_id),
			order_date DATE NOT NULL,
			quantity INT NOT NULL,
			);



/*Question2. Insert data into your tables ( DML part )*/
INSERT INTO customertable(customer_id, customer_name, customer_Tel)
VALUES					(1, 'Alice', '+23480537219'),
						(2, 'Bob', '+2347042319553'),
						(3, 'Charlie', '+2349173245611');
SELECT * FROM customertable

INSERT INTO producttable(product_id, product_name, category, price)
VALUES					(1, 'Widget', 'CAT1', 10.00),
						(2, 'Gadget', 'CAT2', 20.00),
						(3, 'Doohickey', 'CAT3', 15.00);
SELECT * FROM producttable;

INSERT INTO ordertable(order_id, customer_id, product_id, order_date, quantity)
VALUES				(1, 1, 1, '2021-01-01', 10),
					(2, 1, 2, '2021-01-02', 5),
					(3, 2, 1, '2021-01-03', 3),
					(4, 2, 2, '2021-01-04', 7),
					(5, 3, 1, '2021-01-05', 2),
					(6, 3, 3, '2021-01-06', 3);
SELECT * FROM ordertable;

/*Question3. Write a SQL query to retrieve the names of the customers who have placed an order for at 
least one widget and at least one gadget, along with the total cost of the widgets and gadgets 
ordered by each customer. The cost of each item should be calculated by multiplying the 
quantity by the price of the product.*/
SELECT 
		customer_name, 
		product_name, 
		quantity * price AS total_cost 
FROM	customertable 
JOIN	ordertable ON ordertable.customer_id = customertable.customer_id 
JOIN	producttable ON ordertable.product_id = producttable.product_id
WHERE	producttable.product_name = 'Widget' OR producttable.product_name = 'Gadget';

/*Question4. Write a query to retrieve the names of the customers who have placed an order 
for at least one widget, along with the total cost of the widgets ordered by each customer*/
SELECT
		customer_name,
		product_name,
		quantity*price AS total_cost
FROM	customertable
JOIN	ordertable ON ordertable.customer_id=customertable.customer_id
JOIN	producttable ON producttable.product_id=ordertable.product_id
WHERE	producttable.product_id=1

/*Question5. Write a query to retrieve the names of the customers who have placed an order for at least 
one gadget, along with the total cost of the gadgets ordered by each customer*/
SELECT	customer_name,
		product_name,
		ordertable.quantity*producttable.price AS total_cost
FROM	customertable
JOIN	ordertable ON ordertable.customer_id=customertable.customer_id
JOIN	producttable ON ordertable.product_id=producttable.product_id
WHERE	producttable.product_id=2

/*QUESTION6. Write a query to retrieve the names of the customers who have placed an order for at least one 
doohickey, along with the total cost of the doohickeys ordered by each customer.*/
SELECT
		customer_name,
		product_name,
		quantity*price AS total_cost
FROM	customertable
JOIN	ordertable ON ordertable.customer_id=customertable.customer_id
JOIN	producttable ON producttable.product_id=ordertable.product_id
WHERE
	producttable.product_id=3


/*Question7. Write a query to retrieve the total number of widgets and gadgets ordered by each 
customer, along with the total cost of the orders*/
SELECT	customer_name,
		product_name, 
		SUM(CASE WHEN product_name = 'widget' THEN quantity ELSE 0 END) AS total_widgets_ordered,
		SUM(CASE WHEN product_name = 'gadget' THEN quantity ELSE 0 END) AS total_gadgets_ordered,
		SUM(quantity * price) AS total_cost 
FROM	customertable
JOIN	ordertable ON ordertable.customer_id = customertable.customer_id
JOIN	 producttable ON producttable.product_id = ordertable.product_id
WHERE	product_name IN ('widget', 'Gadget')
GROUP BY customer_name, product_name
ORDER BY customer_name;						

/*Question8. Write a query to retrieve the names of the products that have been ordered by at least one 
customer, along with the total quantity of each product ordered*/
SELECT	DISTINCT(product_name),
		SUM(quantity) AS total_quantity
FROM	ordertable
JOIN	producttable ON producttable.product_id = ordertable.product_id
WHERE	producttable.product_id IN (1,2,3)
GROUP BY product_name;

/*Question9. Write a query to retrieve the names of the customers who have placed the most 
orders, along with the total number of orders placed by each customer*/

SELECT customer_name,
		COUNT(order_id) AS overall_order
FROM	customertable
JOIN	ordertable ON ordertable.customer_id=customertable.customer_id
GROUP BY customer_name

/*Question10. Write a query to retrieve the names of the products that have been ordered the most, 
along with the total quantity of each product ordered.*/

SELECT	product_name,
		COUNT(order_id) AS order_most,
		SUM(quantity) AS Total_quantity
FROM producttable
JOIN ordertable ON producttable.product_id = ordertable.product_id
GROUP BY product_name
ORDER BY order_most DESC;

/*Question11. Write a query to retrieve the names of the customers who have placed an order on 
every day of the week, along with the total number of orders placed by each customer.*/

SELECT customer_name, 
DATENAME(DW, order_date) AS day_order,
COUNT(order_id) AS order_count
FROM customertable
INNER JOIN ordertable ON ordertable.customer_id = customertable.customer_id
GROUP BY customer_name, DATENAME(DW, order_date)
ORDER BY customer_name












