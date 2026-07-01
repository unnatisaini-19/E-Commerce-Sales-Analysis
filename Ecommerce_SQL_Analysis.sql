CREATE DATABASE ecommerce_data_analysis;
USE ecommerce_data_analysis;

ALTER TABLE `orders data`
RENAME TO orders_data;
ALTER TABLE `orders item data`
RENAME TO orders_item_data;
ALTER TABLE `customer data`
RENAME TO customer_data;
ALTER TABLE `products data`
RENAME TO products_data;
ALTER TABLE `payment data`
RENAME TO payment_data;
ALTER TABLE `category translation`
RENAME TO category_translation;

SELECT COUNT(*) FROM orders_data;
SELECT COUNT(*) FROM orders_item_data;
SELECT COUNT(*) FROM customer_data;
SELECT COUNT(*) FROM products_data;
SELECT COUNT(*) FROM payment_data;
SELECT COUNT(*) FROM category_translation;

-- order status count
SELECT order_status, COUNT(*) FROM orders_data GROUP BY order_status;

-- payment type count
SELECT payment_type, COUNT(*) FROM payment_data GROUP BY payment_type;

-- product category count (top 10)
SELECT product_category_name_english, COUNT(*) FROM products_data GROUP BY product_category_name_english ORDER BY COUNT(*) DESC limit 10;

-- total revenue
SELECT SUM(payment_value) FROM payment_data;

-- average payment value
SELECT AVG(payment_value) FROM payment_data;

-- maximum payment value
SELECT MAX(payment_value) FROM payment_data;

-- minimum payment value 
SELECT MIN(payment_value) FROM payment_data;

-- top 10 states by customer
SELECT customer_state, COUNT(*) FROM customer_data GROUP BY customer_state ORDER BY COUNT(*) DESC LIMIT 10;

-- top 10 cities by customer
SELECT customer_city, COUNT(*) FROM customer_data GROUP BY customer_city ORDER BY COUNT(*) DESC LIMIT 10;

-- bottom 10 cities by customer 
SELECT customer_city, COUNT(*) FROM customer_data GROUP BY customer_city ORDER BY COUNT(*) ASC LIMIT 10;

-- revenue by payment type
SELECT payment_type, SUM(payment_value) FROM payment_data GROUP BY payment_type ORDER BY SUM(payment_value) DESC;

-- average payment by payment type
SELECT payment_type, AVG(payment_value) FROM payment_data GROUP BY payment_type ORDER BY AVG(payment_value) DESC;

-- maximum payment by payment type
SELECT payment_type, MAX(payment_value) FROM payment_data GROUP BY payment_type;

-- minimum payment by payment type
SELECT payment_type, MIN(payment_value) FROM payment_data GROUP BY payment_type ORDER BY MIN(payment_value) ASC; 

-- revenue + order count by payment type 
SELECT payment_type, COUNT(*), SUM(payment_value) FROM payment_data GROUP BY payment_type ORDER BY SUM(payment_value) DESC;

-- order status count (sorted)
SELECT order_status, COUNT(*) FROM orders_data GROUP BY order_status ORDER BY COUNT(*) DESC; 

-- top selling product categories
SELECT p.product_category_name_english, COUNT(*) AS total_sales FROM orders_item_data oi 
JOIN products_data p ON oi.product_id = p.product_id GROUP BY p.product_category_name_english ORDER BY total_sales DESC LIMIT 10;

-- state wise revenue
SELECT c.customer_state, SUM(payment_value) AS total_revenue FROM customer_data c 
JOIN orders_data o ON c.customer_id = o.customer_id 
JOIN payment_data p ON o.order_id = p.order_id GROUP BY c.customer_state ORDER BY total_revenue DESC;

-- category wise revenue
SELECT p.product_category_name_english, SUM(price) AS total_revenue FROM orders_item_data oi 
JOIN products_data p ON oi.product_id = p.product_id GROUP BY p.product_category_name_english ORDER BY total_revenue DESC;

-- top 10 customer by revenue
SELECT c.customer_unique_id, SUM(payment_value) AS total_revenue FROM customer_data c 
JOIN orders_data o ON c.customer_id = o.customer_id 
JOIN payment_data p ON o.order_id = p.order_id GROUP BY c.customer_unique_id ORDER BY total_revenue DESC LIMIT 10;

-- average order value by state
SELECT c.customer_state, AVG(payment_value) AS total_average FROM customer_data c 
JOIN orders_data o ON c.customer_id = o.customer_id 
JOIN payment_data p ON o.order_id = p.order_id GROUP BY c.customer_state ORDER BY total_average DESC;

-- product category wise average price
SELECT p.product_category_name_english, AVG(oi.price) AS average_price FROM orders_item_data oi 
JOIN products_data p ON oi.product_id = p.product_id GROUP BY p.product_category_name_english ORDER BY average_price DESC;

-- product category wise average weight
SELECT product_category_name_english, AVG(product_weight_g) AS average_weight FROM products_data 
GROUP BY product_category_name_english ORDER BY average_weight DESC;

-- top product by revenue
SELECT p.product_id, SUM(price) FROM orders_item_data oi 
JOIN products_data p ON oi.product_id = p.product_id GROUP BY p.product_id ORDER BY SUM(price) DESC LIMIT 10;

-- state wise order count
SELECT c.customer_state, COUNT(order_id) FROM customer_data c 
JOIN orders_data o ON c.customer_id = o.customer_id GROUP BY c.customer_state ORDER BY COUNT(order_id) DESC;  

-- customer distribution by state
SELECT customer_state, COUNT(customer_unique_id) FROM customer_data GROUP BY customer_state ORDER BY COUNT(customer_unique_id) DESC;

-- revenue vs order count by state
SELECT c.customer_state, COUNT(*) AS total_count, SUM(payment_value) AS total_revenue FROM customer_data c 
JOIN orders_data o ON c.customer_id = o.customer_id 
JOIN payment_data p ON o.order_id = p.order_id GROUP BY c.customer_state ORDER BY total_count DESC, total_revenue DESC;

-- revenue by product category and payment type
SELECT p.product_category_name_english, pd.payment_type, SUM(pd.payment_value) AS total_revenue FROM products_data p 
JOIN orders_item_data oi ON p.product_id = oi.product_id 
JOIN orders_data o ON oi.order_id = o.order_id
JOIN payment_data pd ON o.order_id = pd.order_id GROUP BY p.product_category_name_english, pd.payment_type ORDER BY total_revenue DESC;









