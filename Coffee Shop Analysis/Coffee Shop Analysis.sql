
use coffee;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Beginner Level (Focus: Basic SELECT, WHERE, ORDER BY, Aggregates)

-- 1. Retrieve all columns and rows from the Customers table.
SELECT * FROM CUSTOMERS;


-- 2. List the names (product_name) and prices (price) of all products.
SELECT * FROM PRODUCTS;
SELECT PRODUCT_NAME, PRICE FROM PRODUCTS;


-- 3. Find all customers who live in 'Mumbai'.
SELECT CONCAT(FIRST_NAME," " ,LAST_NAME) FROM CUSTOMERS WHERE WORKING_CITY = "MUMBAI"; # 27 pEOPLE STAYED IN MUMBAI


-- 4. List all product names and their categories, ordered by product name alphabetically.
SELECT PRODUCT_NAME, CATEGORY FROM PRODUCTS ORDER BY 1 ASC; # IN TOTAL WE HAVE 6 PRODUCTS


-- 5. How many customers are registered in the database?
SELECT DISTINCT CONCAT(FIRST_NAME," " ,LAST_NAME) FROM CUSTOMERS; # 95 CUSTOMERS ARE REGISTERED 


-- 6. What is the total number of orders placed?
SELECT * FROM ORDERS;
SELECT COUNT(ORDER_ID) FROM ORDERS; # IN TOTAL WE HAVE 751 ORDERS



-- 7. Find the details of the order with order_id 1500.
SELECT * FROM ORDERS WHERE ORDER_ID = 1500;


-- 8. List all customer email addresses.
SELECT * FROM CUSTOMERS;
SELECT EMAIL FROM CUSTOMERS;


-- 9. Show the product names and stock levels for products with less than 300 units in stock.
SELECT PRODUCT_NAME , STOCK FROM PRODUCTS WHERE STOCK < 300; # 3 PRODUCTS HAVE STOCK LESS THAN 300


-- 10. Show all orders placed on January 15th, 2024.
SELECT * FROM ORDERS WHERE ORDER_DATE = "2024-01-15";


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Rookie Level (Focus: Simple JOINs, GROUP BY, HAVING, Basic Subqueries, Date Functions)

-- 11. List the first name, last name, and order date for all orders placed. (Requires JOIN)
SELECT C.FIRST_NAME, C.LAST_NAME, O.ORDER_DATE 
FROM CUSTOMERS C JOIN ORDERS O 
USING(CUSTOMER_ID);


-- 12. Show the product name and the quantity ordered for order_id 1003. (Requires JOIN)
SELECT P.PRODUCT_NAME, OD.QUANTITY, OD.ORDER_ID 
FROM PRODUCTS P JOIN orderdetails OD USING(PRODUCT_ID)
WHERE ORDER_ID = 1003;


-- 13. List all customer names (first_name, last_name) who placed an order in January 2024. (Requires JOIN and Date Function)
SELECT concat(C.FIRST_NAME, " ", C.LAST_NAME) AS NAME, O.ORDER_DATE
FROM CUSTOMERS C JOIN ORDERS O USING(CUSTOMER_ID)
WHERE MONTH(O.ORDER_DATE) = 1 AND year(O.ORDER_DATE) = 2024;


-- 14. Calculate the total quantity of items sold for each product. Display product_name and total quantity. (Requires JOIN and GROUP BY)
SELECT SUM(OD.QUANTITY) AS TOTAL_QUANTITY, P.PRODUCT_NAME 
FROM orderdetails OD JOIN PRODUCTS P USING(PRODUCT_ID)
GROUP BY 2;


-- 15. Find the total sales amount (total_amount) for each customer. Display customer_id, first_name, last_name, and their total spending. (Requires JOIN and GROUP BY)
SELECT SUM(O.TOTAL_AMOUNT) AS TOTAL_SPENDING, C.FIRST_NAME, C.LAST_NAME, C.CUSTOMER_ID 
FROM ORDERS O JOIN CUSTOMERS C USING(CUSTOMER_ID)
GROUP BY 2,3,4;


-- 16. Find the names of products that have been ordered at least 50 times (in terms of total quantity across all orders). (Requires JOIN, GROUP BY, HAVING)
SELECT P.PRODUCT_NAME, COUNT(OD.PRODUCT_ID) FROM products P JOIN orderdetails OD
USING(PRODUCT_ID) GROUP BY 1 HAVING COUNT(OD.product_id) >= 50;


-- 17. List the names of customers who registered in the last quarter of 2023 (Oct-Dec). (Requires Date Function)
SELECT * FROM CUSTOMERS WHERE QUARTER(REGISTRATION_DATE) = 4; # SO 79 PEOPLE REGISTERED IN THE LAST QUARTER OF 2023


-- 18. Find the order_id for all orders containing 'Espresso'. (Requires JOIN and WHERE)
SELECT O.ORDER_ID, P.PRODUCT_NAME FROM ORDERDETAILS O JOIN PRODUCTS P 
USING(PRODUCT_ID) WHERE P.PRODUCT_NAME = 'ESPRESSO'; # IN TOTAL 281 ORDER ID'S HAVE ESPRESSO


-- 19. What is the average order total_amount?
SELECT AVG(TOTAL_AMOUNT) FROM ORDERS; # SO AVERAGE ORDER TOTAL AMT IS 810.78


-- 20. List the customers (customer_id, first_name) who have placed more than 3 orders. (Requires GROUP BY, HAVING)
SELECT C.CUSTOMER_ID, C.FIRST_NAME, COUNT(O.ORDER_ID) FROM CUSTOMERS C JOIN ORDERS O USING(CUSTOMER_ID)
GROUP BY 1,2 HAVING COUNT(O.ORDER_ID) > 3;


-- 21. Find the product_id and product_name for products whose price is higher than the average price of all products. (Requires Subquery)
SELECT PRODUCT_ID, PRODUCT_NAME, PRICE FROM PRODUCTS
WHERE PRICE > (SELECT AVG(PRICE) FROM PRODUCTS);	# 3 PRODUCTS HAVE HIGHER PRICE THAN WHOLE AVG


-- 22. Show the order_id and order_date for orders placed by customers from 'Delhi'. (Requires Subquery or JOIN)
SELECT ORDER_ID, ORDER_DATE FROM ORDERS 
WHERE CUSTOMER_ID IN 
(SELECT CUSTOMER_ID FROM CUSTOMERS WHERE WORKING_CITY = 'DELHI');	# IN TOTAL 77 ORDER IDS  ARE FROM DELHI


-- 23. List the different states (address_state) present in the Customers table without duplicates.
SELECT distinct BIRTH_STATE FROM CUSTOMERS;


-- 24. Find the total revenue generated from 'Beverage' category products. Calculate using OrderDetails.quantity and Products.price. (Requires JOIN, WHERE, SUM)
SELECT SUM(O.QUANTITY * P.PRICE) AS REVENUE, P.CATEGORY FROM orderdetails O JOIN products P 
USING(PRODUCT_ID) WHERE P.category = "BEVERAGE" GROUP BY 2;	 # TOTAL REVENUE OF 4,51,320


-- 25. List the cities where customers have placed orders totalling more than $2000. (Requires JOIN, GROUP BY, HAVING).
SELECT  SUM(O.QUANTITY * P.PRICE) AS REVENUE, C.WORKING_CITY 
FROM orderdetails O JOIN PRODUCTS P USING(PRODUCT_ID)
JOIN ORDERS USING(ORDER_ID) JOIN CUSTOMERS C USING(CUSTOMER_ID)
GROUP BY 2 HAVING SUM(O.QUANTITY * P.PRICE) > 2000;


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Intermediate Level (Focus: Complex JOINs, Subqueries, Window Functions, CASE, Pivoting)

-- 26. List the top 5 customers based on their total spending (total_amount). Display customer name and total spending. (Requires JOIN, GROUP BY, ORDER BY, LIMIT)
SELECT SUM(o.total_amount), concat(first_name, " " , last_name) as full_name 
from orders o join customers using(customer_id) 
group by 2
order by 1 desc
limit 5
offset 0;


-- 27. For each customer, find their first order date. Display customer_id, name, and first_order_date. (Requires Window Function MIN() OVER() or Subquery/GROUP BY)
SELECT C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, (SELECT MIN(ORDER_DATE) FROM  ORDERS O WHERE C.CUSTOMER_ID = O.CUSTOMER_ID) AS FIRST_ORDER_DATE FROM CUSTOMERS C ;

 
-- 28. Rank products based on their total sales quantity (sum of OrderDetails.quantity). Display product_name, total quantity, and rank. (Requires JOIN, GROUP BY, Window Function RANK() or DENSE_RANK())
WITH TEM AS 
	(SELECT PRODUCT_NAME, SUM(OD.QUANTITY) AS TOT
	FROM PRODUCTS JOIN ORDERDETAILS OD USING(PRODUCT_ID) 
	GROUP BY 1)
SELECT PRODUCT_NAME, RANK() OVER (ORDER BY TOT) AS RANKING FROM TEM;


-- 29. Find customers who ordered both 'Espresso' and 'Masala Chai'. List their customer_id and names. (Requires JOIN, GROUP BY, HAVING, or Subqueries)
SELECT C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, P.PRODUCT_NAME
FROM CUSTOMERS C JOIN ORDERS USING(CUSTOMER_ID)
JOIN orderdetails USING(ORDER_ID) 
JOIN PRODUCTS P USING(PRODUCT_ID)
WHERE P.PRODUCT_NAME IN ("ESPRESSO", "MASALA CHAI")
GROUP BY 1,2,3,4
having COUNT(DISTINCT P.PRODUCT_NAME) = 2; 	# NO ONE ORDERED IN SUCH A WAY


-- 30. Calculate the running total of total_amount for orders placed in January 2024, ordered by order_date. (Requires Window Function SUM() OVER())
SELECT *, SUM(TOTAL_AMOUNT) OVER (ORDER BY ORDER_DATE) FROM ORDERS WHERE MONTH(ORDER_dATE) = 1;


-- 31. Find the difference in days between the registration date and the first order date for each customer who has placed an order. (Requires JOIN, Subquery/Window Function, Date Functions)
SELECT C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, MIN(O.ORDER_DATE) AS FIRST_ORDER_DATE, datediff(MIN(O.ORDER_DATE), C.REGISTRATION_DATE) AS DIFFERENCE
FROM CUSTOMERS C JOIN ORDERS O USING(CUSTOMER_ID)
GROUP BY 1,2,3
HAVING COUNT(O.ORDER_ID) > 0;



-- 32. Pivot: Show the total quantity sold for each product category ('Beverage', 'Tea') in each customer state. Display BIRTH state as rows and categories as columns. (Requires JOIN, GROUP BY, CASE statement PIVOT)
SELECT C.BIRTH_STATE,
SUM(CASE WHEN P.CATEGORY = "TEA" THEN OD.QUANTITY ELSE 0 END) AS TEA, 
SUM(CASE WHEN P.CATEGORY = "BEVERAGE" THEN OD.QUANTITY ELSE 0 END) AS BEVERAGE
FROM customers C JOIN ORDERS O USING(CUSTOMER_ID)
JOIN orderdetails OD USING(ORDER_ID)
JOIN PRODUCTS P USING(PRODUCT_ID)
GROUP BY C.Birth_State;


-- 33. Classify customers based on their total spending: 'High' (> $1500), 'Medium' ($500-$1500), 'Low' (< $500). Display customer_id, name, total spending, and spending category. (Requires JOIN, GROUP BY, CASE statement)
SELECT C.CUSTOMER_ID, CONCAT(C.FIRST_NAME, " " , C.LAST_NAME) AS FULLNAME, SUM(O.TOTAL_AMOUNT),
CASE WHEN SUM(O.TOTAL_AMOUNT) > 1500 THEN "HIGH" 
WHEN  SUM(O.TOTAL_AMOUNT) BETWEEN 500 AND 1500 THEN "MEDIUM"
WHEN SUM(O.TOTAL_AMOUNT) < 500 THEN "LOW" END AS SPENDING_CATEGORY
FROM CUSTOMERS C JOIN ORDERS O USING(CUSTOMER_ID)
GROUP BY 1,2;


-- 34. Find the order details (order_id, product_name, quantity) for orders where the quantity of any single item is greater than the average quantity per item across all orders. (Requires Subquery on OrderDetails)
-- 35. List products that were never sold. (Requires LEFT JOIN/IS NULL or Subquery with NOT IN/NOT EXISTS)
SELECT P.PRODUCT_ID FROM PRODUCTS P WHERE P.PRODUCT_ID NOT IN (SELECT PRODUCT_ID FROM ORDERDETAILS);

# OR USING CORRELATED SUBQUERY

SELECT P.PRODUCT_ID FROM PRODUCTS P WHERE NOT EXISTS
(SELECT 1 FROM ORDERDETAILS OD WHERE OD.PRODUCT_ID = P.PRODUCT_ID);


-- 36. Calculate the month-over-month growth rate in total sales (total_amount). (Requires Window Functions LAG(), Date Functions, GROUP BY Month)
with tem_1 as 
	(select date_format(order_date,"%m, %y") as salemonth, sum(total_amount) as monthly_total from orders group by 1),
    tem_2 as
		(select monthly_total, salemonth , lag(monthly_total, 1) over (order by salemonth) as pre_mon_total,
        monthly_total - lag(monthly_total,1) over(order by salemonth) * 100 as mon_mon_growth_rate from tem_1)
        
select salemonth, monthly_total, round(mon_mon_growth_rate, 4) as growth_rate from tem_2 order by 1;


-- 37. Find the average time (in days) between consecutive orders for each customer who has placed more than one order. (Requires Window Functions LAG() or LEAD(), Date Functions, GROUP BY Customer)
with tem as 
	(Select customer_id, order_date, lag(order_date, 1) over(partition by customer_id order by order_date) as prev_order_date from orders)
    
select customer_id, avg(datediff( order_date, prev_order_date)) as diff from tem where prev_order_date is not null group by 1 having count(prev_order_date) > 0;




-- 38. Pivot: Display the total sales amount (quantity * price) for each product (product_name) broken down by month for the year 2024. Rows should be products, columns should be months (Jan, Feb, etc.). (Requires JOINs, Date Functions, GROUP BY, CASE statement PIVOT)
select p.product_name,
sum(case when month(o.order_date) = 1 then od.quantity*od.retail_price else 1 end) as Jan_Sales,
sum(case when month(o.order_date) = 2 then od.quantity*od.retail_price else 1 end) as Feb_Sales,
sum(case when month(o.order_date) = 3 then od.quantity*od.retail_price else 0 end) as Mar_Sales,
sum(case when month(o.order_date) = 4 then od.quantity*od.retail_price else 0 end) as Apr_Sales,
sum(case when month(o.order_date) = 5 then od.quantity*od.retail_price else 0 end) as May_Sales,
sum(case when month(o.order_date) = 6 then od.quantity*od.retail_price else 0 end) as Jun_Sales,
sum(case when month(o.order_date) = 7 then od.quantity*od.retail_price else 0 end) as Jul_Sales,
sum(case when month(o.order_date) = 8 then od.quantity*od.retail_price else 0 end) as Aug_Sales,
sum(case when month(o.order_date) = 9 then od.quantity*od.retail_price else 0 end) as Sept_Sales,
sum(case when month(o.order_date) = 10 then od.quantity*od.retail_price else 0 end) as Oct_Sales,
sum(case when month(o.order_date) = 11 then od.quantity*od.retail_price else 0 end) as Nov_Sales,
sum(case when month(o.order_date) = 12 then od.quantity*od.retail_price else 0 end) as Dec_Sales
from products p join orderdetails od using(product_id)
join orders o using(order_id)
where extract(year from o.order_date) = 2024
group by 1
order by 1;


    
-- 40. For each product category, find the product with the highest unit price within that category. Display category and product name. (Requires Window Function ROW_NUMBER() or RANK() partitioned by category or Subquery)
select category, product_name, price , rank() over(partition by category order by price desc) as Ranking from products;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Master Level (Focus: Advanced Window Functions, Complex Logic, CTEs, Optimization Concepts)

-- 41. (Using CTE) Define a Common Table Expression (CTE) for customer total spending, then use it to find the percentage of total revenue contributed by the top 10% of customers.
with sumup as
	(Select c.Customer_id, sum(o.total_amount) as total_spending from customers c join orders o using(customer_id) group by 1),
    
ntiling as
	(select customer_id, total_spending, ntile(10) over(order by total_spending desc) as spending from sumup)
    
    
select
sum(case when spending = 1 then total_spending else 0 end)* 100 / sum(total_spending) as Top_10_percent from ntiling;
    



-- 42. Calculate the 7-day moving average of the total daily sales amount (total_amount) for January 2024. (Requires Window Function with frame clause ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
with tem as 
	(select date(order_date) as sale_date, total_amount, (total_amount) as sum_up from orders where month(order_date) = 1 and year(order_date) = 2024 group by 1,2)
    
select sale_date, total_amount, avg(total_amount) over(order by sale_date rows between 6 preceding and current row) as 6_day_rolling_avg from tem;


-- 43. Identify "loyal" customers: those who placed an order in every month of a specific period (e.g., Q4 2023, based on registration_date, or Jan 2024 based on order_date). Assume orders only exist for Jan 2024 based on data. Find customers who ordered in Jan 2024. (A more complex version would involve checking across multiple months if data existed). (Requires GROUP BY, COUNT DISTINCT Month)
Select distinct month(order_date) from orders;
# So we only have the data having order_date of month of jan 2024

Select distinct concat(c.first_name, " ", c.last_name) as Name, o.order_date from customers c join orders o using(customer_id) where month(o.order_date) = 1;


-- 44. Find pairs of products that are frequently bought together in the same order. List pairs (product_id_1, product_id_2) and the number of times they appeared together. (Requires Self-Join on OrderDetails, GROUP BY)
select od1.product_id as Product_Id_1,
od2.product_id as Product_Id_2,
count(*) as Total_Appearance
from orderdetails od1 join orderdetails od2 using(order_id)
where od1.product_id < od2.product_id
group by 1,2
order by total_appearance desc;


-- 45. Assign customers into quartiles (4 groups) based on their total spending. Display customer_id, name, total spending, and quartile number. (Requires Window Function NTILE(4))
with tem as 
	(Select customer_id, sum(total_amount) as total_spending from orders group by 1)
    ,tem2 as
    (select t.customer_id, c.first_name, c.Birth_State, t.total_spending, ntile(4) over(order by t.total_spending) as Quartile_number
    from customers c join tem t using(customer_id))
    
    select * from tem2 where quartile_number = 1;
    
    
