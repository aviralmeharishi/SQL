CREATE DATABASE IF NOT EXISTS coffee;

USE coffee;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    contact_number VARCHAR(20), -- Assuming VARCHAR for potential special characters like '+' or '()'
    working_city VARCHAR(50),
    Birth_State VARCHAR(50), -- Consider renaming to birth_state for consistency
    registration_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    region_id INT, -- Assuming region_id is an INT; adjust if it's a different type or references another table not shown
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details ( -- Renamed from 'orderdeta...' for clarity
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    Retail_Price INT, -- Consider renaming to retail_price and using DECIMAL if fractional values are possible
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);