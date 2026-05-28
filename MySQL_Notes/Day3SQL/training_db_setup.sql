-- ============================================================
--  ADVANCED SQL TRAINING — Complete Sample Database Setup
--  Compatible with: MySQL 8+ / MariaDB
--  Run this entire script before starting the training session
-- ============================================================

DROP DATABASE IF EXISTS training_db;
CREATE DATABASE training_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE training_db;

-- ============================================================
-- TABLE 1: customers
-- ============================================================
CREATE TABLE customers (
    customer_id   INT           PRIMARY KEY,
    name          VARCHAR(100)  NOT NULL,
    city          VARCHAR(50)   NOT NULL,
    email         VARCHAR(100)  UNIQUE NOT NULL,
    joined_date   DATE          NOT NULL
);

INSERT INTO customers VALUES
(1, 'Alice Sharma',   'Mumbai',    'alice@example.com',   '2022-01-15'),
(2, 'Bob Mehta',      'Delhi',     'bob@example.com',     '2022-03-22'),
(3, 'Charlie Nair',   'Bangalore', 'charlie@example.com', '2022-06-10'),
(4, 'David Patel',    'Pune',      'david@example.com',   '2023-01-05'),
(5, 'Eve Kapoor',     'Chennai',   'eve@example.com',     '2023-04-18');

-- ============================================================
-- TABLE 2: products
-- ============================================================
CREATE TABLE products (
    product_id    INT             PRIMARY KEY,
    name          VARCHAR(100)    NOT NULL,
    category      VARCHAR(50)     NOT NULL,
    price         DECIMAL(10,2)   NOT NULL,
    stock         INT             NOT NULL DEFAULT 0,
    CHECK (price > 0),
    CHECK (stock >= 0)
);

INSERT INTO products VALUES
(1, 'Laptop Pro 15',      'Electronics',   75000.00, 25),
(2, 'Wireless Mouse',     'Electronics',     899.00, 150),
(3, 'Office Chair',       'Furniture',      12500.00, 40),
(4, 'USB-C Hub',          'Electronics',    2499.00, 80),
(5, 'Standing Desk',      'Furniture',      18000.00, 15),
(6, 'Noise Cancel Headphones', 'Electronics', 8999.00, 60);

-- ============================================================
-- TABLE 3: orders
-- ============================================================
CREATE TABLE orders (
    order_id      INT             PRIMARY KEY,
    customer_id   INT             NOT NULL,
    order_date    DATE            NOT NULL,
    status        VARCHAR(20)     NOT NULL DEFAULT 'pending',
    total         DECIMAL(10,2)   NOT NULL DEFAULT 0.00,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CHECK (status IN ('pending','processing','shipped','delivered','cancelled'))
);

INSERT INTO orders VALUES
(1001, 1, '2023-02-10', 'delivered',  75899.00),
(1002, 2, '2023-03-15', 'delivered',  21399.00),
(1003, 3, '2023-04-20', 'shipped',    12500.00),
(1004, 1, '2023-05-05', 'delivered',   2499.00),
(1005, 3, '2023-06-18', 'processing', 17998.00),
(1006, 2, '2023-07-22', 'pending',    18000.00),
(1007, 1, '2023-08-30', 'delivered',   8999.00);

-- ============================================================
-- TABLE 4: order_items
-- ============================================================
CREATE TABLE order_items (
    item_id       INT             PRIMARY KEY,
    order_id      INT             NOT NULL,
    product_id    INT             NOT NULL,
    qty           INT             NOT NULL,
    unit_price    DECIMAL(10,2)   NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    CHECK (qty > 0)
);

INSERT INTO order_items VALUES
(5001, 1001, 1, 1, 75000.00),   -- Alice: Laptop
(5002, 1001, 2, 1,   899.00),   -- Alice: Mouse
(5003, 1002, 3, 1, 12500.00),   -- Bob: Chair
(5004, 1002, 4, 2,  2499.00),   -- Bob: 2x USB Hub
(5005, 1002, 2, 1,   899.00),   -- Bob: Mouse  (note: 12500+4998+899 = mismatch for demo; rounded in orders.total)
(5006, 1003, 3, 1, 12500.00),   -- Charlie: Chair
(5007, 1004, 4, 1,  2499.00),   -- Alice: USB Hub
(5008, 1005, 6, 2,  8999.00),   -- Charlie: 2x Headphones
(5009, 1006, 5, 1, 18000.00),   -- Bob: Standing Desk
(5010, 1007, 6, 1,  8999.00);   -- Alice: Headphones

-- ============================================================
-- TABLE 5: employees  (self-referencing for Self Join demo)
-- ============================================================
CREATE TABLE employees (
    emp_id        INT             PRIMARY KEY,
    name          VARCHAR(100)    NOT NULL,
    dept          VARCHAR(50)     NOT NULL,
    manager_id    INT             NULL,          -- NULL = top-level manager
    salary        DECIMAL(10,2)   NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

INSERT INTO employees VALUES
(101, 'Ravi Kumar',    'Management', NULL, 150000.00),  -- CEO / top
(102, 'Sunita Rao',   'Sales',       101,   85000.00),
(103, 'Amit Joshi',   'Tech',        101,   95000.00),
(104, 'Priya Singh',  'Sales',       102,   60000.00),
(105, 'Karan Shah',   'Tech',        103,   72000.00),
(106, 'Neha Gupta',   'Tech',        103,   68000.00);

-- ============================================================
-- TABLE 6: accounts  (for Transaction / ACID demo)
-- ============================================================
CREATE TABLE accounts (
    acc_id        INT             PRIMARY KEY,
    holder        VARCHAR(100)    NOT NULL,
    balance       DECIMAL(12,2)   NOT NULL DEFAULT 0.00,
    CHECK (balance >= 0)
);

INSERT INTO accounts VALUES
(101, 'Alice Sharma', 250000.00),
(202, 'Bob Mehta',     80000.00),
(303, 'Charlie Nair', 120000.00);

-- ============================================================
-- VERIFY: Quick row counts for all tables
-- ============================================================
SELECT 'customers'   AS tbl, COUNT(*) AS rows FROM customers   UNION ALL
SELECT 'products',            COUNT(*)         FROM products    UNION ALL
SELECT 'orders',              COUNT(*)         FROM orders      UNION ALL
SELECT 'order_items',         COUNT(*)         FROM order_items UNION ALL
SELECT 'employees',           COUNT(*)         FROM employees   UNION ALL
SELECT 'accounts',            COUNT(*)         FROM accounts;

-- ============================================================
-- END OF SETUP — training_db is ready!
-- ============================================================
