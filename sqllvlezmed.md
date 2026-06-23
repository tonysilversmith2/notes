# SQL Practice Questions (IAMNeo / Examly Pattern)

---

# Beginner Level Questions

---

## Question 1: Employees with Salary Greater Than 50000

### Table: Employee

| emp_id | emp_name | salary |
|---------|----------|--------|
| 1 | Rahul | 45000 |
| 2 | Priya | 60000 |
| 3 | Aman | 75000 |

### Problem Statement

Write an SQL query to display the names of employees whose salary is greater than 50000.

### Step-by-Step Explanation

#### Step 1: Select employee names

```sql
SELECT emp_name
```

#### Step 2: Specify the table

```sql
FROM Employee
```

#### Step 3: Filter employees

```sql
WHERE salary > 50000;
```

### Final Query

```sql
SELECT emp_name
FROM Employee
WHERE salary > 50000;
```

---

## Question 2: Find Average Marks

### Table: Student

| student_id | name | marks |
|------------|------|------|
| 1 | Rahul | 80 |
| 2 | Priya | 90 |
| 3 | Aman | 70 |

### Problem Statement

Find the average marks of all students.

### Step-by-Step Explanation

Use the `AVG()` function.

### Final Query

```sql
SELECT AVG(marks) AS average_marks
FROM Student;
```

---

## Question 3: Count Total Employees

### Table: Employee

### Problem Statement

Find the total number of employees.

### Step-by-Step Explanation

Use `COUNT(*)` to count rows.

### Final Query

```sql
SELECT COUNT(*) AS total_employees
FROM Employee;
```

---

## Question 4: Find Highest Salary

### Table: Employee

### Problem Statement

Display the highest salary.

### Step-by-Step Explanation

Use the `MAX()` function.

### Final Query

```sql
SELECT MAX(salary) AS highest_salary
FROM Employee;
```

---

## Question 5: Sort Products by Price

### Table: Product

| product_id | product_name | price |
|------------|--------------|-------|
| 1 | Laptop | 50000 |
| 2 | Mouse | 800 |
| 3 | Keyboard | 1200 |

### Problem Statement

Display products in ascending order of price.

### Step-by-Step Explanation

Use `ORDER BY`.

### Final Query

```sql
SELECT *
FROM Product
ORDER BY price ASC;
```

---

# Medium Level Questions

---

## Question 1: Department-wise Employee Count

### Table: Employee

| emp_id | name | department |
|---------|------|------------|
| 1 | Rahul | IT |
| 2 | Priya | HR |
| 3 | Aman | IT |
| 4 | Riya | HR |

### Problem Statement

Find the number of employees in each department.

### Step-by-Step Explanation

1. Group rows by department.
2. Count employees in each group.

### Final Query

```sql
SELECT department,
       COUNT(*) AS total_employees
FROM Employee
GROUP BY department;
```

---

## Question 2: Students Scoring Above Average

### Table: Student

### Problem Statement

Find students whose marks are greater than the average marks.

### Step-by-Step Explanation

#### Find average marks

```sql
SELECT AVG(marks)
FROM Student;
```

#### Compare each student's marks with the average

### Final Query

```sql
SELECT name
FROM Student
WHERE marks >
(
    SELECT AVG(marks)
    FROM Student
);
```

---

## Question 3: Find Second Highest Salary

### Table: Employee

### Problem Statement

Find the second highest salary.

### Step-by-Step Explanation

1. Find the highest salary.
2. Exclude it.
3. Find the maximum among the remaining salaries.

### Final Query

```sql
SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary <
(
    SELECT MAX(salary)
    FROM Employee
);
```

---

## Question 4: Customer Orders Using INNER JOIN

### Table: Customer

| customer_id | customer_name |
|-------------|---------------|
| 1 | Rahul |
| 2 | Priya |

### Table: Orders

| order_id | customer_id | amount |
|----------|-------------|-------|
| 101 | 1 | 5000 |
| 102 | 2 | 7000 |

### Problem Statement

Display customer names along with their order amounts.

### Step-by-Step Explanation

Join the tables using `customer_id`.

### Final Query

```sql
SELECT customer_name,
       amount
FROM Customer
INNER JOIN Orders
ON Customer.customer_id = Orders.customer_id;
```

---

## Question 5: Departments Having More Than Two Employees

### Table: Employee

### Problem Statement

Display departments that contain more than two employees.

### Step-by-Step Explanation

1. Group employees by department.
2. Count employees in each group.
3. Use `HAVING` to filter groups.

### Final Query

```sql
SELECT department,
       COUNT(*) AS total_employees
FROM Employee
GROUP BY department
HAVING COUNT(*) > 2;
```

---

# Frequently Asked IAMNeo / Examly Patterns

## WHERE

```sql
SELECT *
FROM table_name
WHERE condition;
```

## ORDER BY

```sql
SELECT *
FROM table_name
ORDER BY column ASC;
```

## COUNT

```sql
SELECT COUNT(*)
FROM table_name;
```

## AVG

```sql
SELECT AVG(column)
FROM table_name;
```

## MAX

```sql
SELECT MAX(column)
FROM table_name;
```

## GROUP BY

```sql
SELECT column, COUNT(*)
FROM table_name
GROUP BY column;
```

## HAVING

```sql
SELECT column, COUNT(*)
FROM table_name
GROUP BY column
HAVING COUNT(*) > value;
```

## INNER JOIN

```sql
SELECT columns
FROM table1
INNER JOIN table2
ON table1.id = table2.id;
```

## Subquery

```sql
SELECT *
FROM table_name
WHERE column >
(
    SELECT AVG(column)
    FROM table_name
);
```