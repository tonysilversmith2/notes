# IAMNEO / Examly / NeoColab Preparation Guide

A complete revision guide for Python, NumPy, OOP, Pandas, and SQL patterns frequently asked in LTM Milestone assessments.

---

# Table of Contents

1. OOP Basics
2. NumPy Array Creation
3. Array Validation
4. Aggregation Functions
5. Rounding Values
6. Classification using np.where()
7. Longest Increasing Streak
8. List Comprehension
9. String Formatting
10. NumPy String Arrays
11. Common Analyzer Problems
12. Hidden Test Patterns
13. SQL Questions
14. Window Functions
15. Most Important Functions
16. Frequently Asked Problems

---

# 1. OOP Basics

```python
class Student:

    def greet(self):
        return "Hello"

s = Student()

print(s.greet())
```

Output:

```
Hello
```

---

# 2. NumPy Array Creation

```python
import numpy as np

arr = np.array(
    [10,20,30],
    dtype=np.float64
)
```

Output:

```python
array([10.,20.,30.])
```

Common Pattern

```python
def create_array(data):
    return np.array(data,dtype=np.float64)
```

---

# 3. Array Validation

```python
arr.size
```

Output

```
3
```

```python
np.any(arr < 0)
```

Output

```
False
```

Pattern

```python
if arr.size == 0:
    return False

if np.any(arr < 0):
    return False
```

---

# 4. Aggregation Functions

Most Important Functions

```python
np.sum()
np.mean()
np.max()
np.min()
```

Example

```python
arr = np.array([10,20,30])

np.sum(arr)
# 60

np.mean(arr)
# 20.0

np.max(arr)
# 30

np.min(arr)
# 10
```

---

# 5. Rounding Values

```python
round(12.56789,2)
```

Output

```
12.57
```

Pattern

```python
average = round(
    float(np.mean(arr)),
    2
)
```

---

# 6. Classification using np.where()

```python
arr = np.array([10,20,30])

np.where(
    arr >= 20,
    "High",
    "Low"
)
```

Output

```python
array(['Low','High','High'])
```

---

# 7. Longest Increasing Streak

Input

```python
[10,20,15,18,25,30]
```

Output

```
4
```

Logic

```python
longest = 1
current = 1

for i in range(1,len(arr)):

    if arr[i] > arr[i-1]:
        current += 1

    else:
        longest = max(longest,current)
        current = 1

longest = max(longest,current)
```

---

# 8. List Comprehension

```python
[x*2 for x in [1,2,3]]
```

Output

```python
[2,4,6]
```

---

# 9. String Formatting

```python
value = 120

f"{value} units"
```

Output

```
120 units
```

---

# 10. NumPy String Arrays

```python
np.array(
[
f"{int(v)} units"
for v in arr
]
)
```

Output

```python
array(['120 units','95 units'])
```

---

# 11. Common Analyzer Problems

These problems follow almost identical logic.

- Sales Performance Analyzer
- Website Traffic Analyzer
- Inventory Analyzer
- Weather Analyzer
- Energy Consumption Analyzer
- Student Score Analyzer
- Sensor Data Analyzer
- Hospital Patient Analytics
- Website Traffic Monitor
- Stock Market Trend Analyzer

---

## Sales Performance Analyzer

Methods

- create_sales_array()
- validate_sales_array()
- compute_sales_metrics()
- classify_sales()
- longest_growth_streak()
- format_sales_report()

Classification

```
>= target → High
< target → Low
```

---

## Website Traffic Analyzer

Methods

- create_traffic_array()
- validate_traffic_array()
- compute_traffic_metrics()
- classify_traffic()
- longest_growth_streak()
- format_traffic_report()

Classification

```
>= target → Busy
< target → Normal
```

---

## Inventory Analyzer

```
>= target → Sufficient
< target → Low Stock
```

---

## Student Score Analyzer

```
>= target → Pass
< target → Fail
```

---

## Weather Analyzer

```
>= threshold → Hot
< threshold → Cold
```

---

# 12. Common Hidden Test Patterns

## Pattern 1

```python
np.array(data,dtype=np.float64)
```

## Pattern 2

```python
np.any(arr < 0)
```

## Pattern 3

```python
np.sum(arr)
np.mean(arr)
np.max(arr)
np.min(arr)
```

## Pattern 4

```python
np.where(
    arr >= threshold,
    "High",
    "Low"
)
```

## Pattern 5

Longest Increasing Streak

```python
[10,20,15,18,25,30]
```

Answer

```
4
```

## Pattern 6

String Formatting

```python
f"{int(value)} units"
```

---

# Mini Questions

## Q1

Create a NumPy array from

```python
[10,20,30]
```

Return dtype float64.

---

## Q2

Return False if array contains negative values.

---

## Q3

Return

```python
(total, average, maximum)
```

for

```python
[100,200,300]
```

---

## Q4

Classify

```
>=50 → Pass
<50 → Fail
```

using np.where().

---

## Q5

Find longest increasing streak

```python
[5,10,15,2,3,4,5]
```

Answer

```
4
```

---

# SQL Question 1

Join `monthly_sales` with `products`.

Retrieve previous month's sales using `LAG()`.

Calculate month-over-month sales change.

Return all months.

Sort by:

1. product_name ascending
2. sale_month ascending

```sql
SELECT
    p.product_name,
    ms.sale_month,
    ms.amount,

    LAG(ms.amount)
    OVER(
        PARTITION BY ms.product_id
        ORDER BY ms.sale_month
    ) AS previous_amount,

    ms.amount -
    LAG(ms.amount)
    OVER(
        PARTITION BY ms.product_id
        ORDER BY ms.sale_month
    ) AS amount_change

FROM monthly_sales ms
JOIN products p
ON ms.product_id = p.product_id

ORDER BY
    p.product_name ASC,
    ms.sale_month ASC;
```

For first month:

```
previous_amount = NULL
amount_change = NULL
```

---

# SQL Question 2

Calculate average order amount for each customer.

Find customers whose average order amount is greater than overall average.

Display:

- customer_name
- total_spent
- number_of_orders

Sort by

1. total_spent DESC
2. customer_name ASC

```sql
SELECT
    customer_name,
    SUM(order_amount) AS total_spent,
    COUNT(*) AS number_of_orders

FROM orders

GROUP BY customer_name

HAVING AVG(order_amount) >
(
    SELECT AVG(order_amount)
    FROM orders
)

ORDER BY
    total_spent DESC,
    customer_name ASC;
```

---

# Window Functions

## ROW_NUMBER()

```sql
SELECT
    *,
    ROW_NUMBER()
    OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) AS rn
FROM employees;
```

---

## RANK()

```sql
SELECT
    employee_name,
    salary,
    RANK()
    OVER(
        ORDER BY salary DESC
    ) AS ranking
FROM employees;
```

---

## DENSE_RANK()

```sql
SELECT
    employee_name,
    salary,
    DENSE_RANK()
    OVER(
        ORDER BY salary DESC
    ) AS ranking
FROM employees;
```

---

## LAG()

```sql
SELECT
    product_id,
    sale_month,
    amount,

    LAG(amount)
    OVER(
        PARTITION BY product_id
        ORDER BY sale_month
    ) AS previous_sales

FROM monthly_sales;
```

---

## LEAD()

```sql
SELECT
    product_id,
    sale_month,
    amount,

    LEAD(amount)
    OVER(
        PARTITION BY product_id
        ORDER BY sale_month
    ) AS next_sales

FROM monthly_sales;
```

---

## Running Total

```sql
SELECT
    sale_date,
    amount,

    SUM(amount)
    OVER(
        ORDER BY sale_date
    ) AS running_total

FROM sales;
```

---

# Most Important Python Functions

```python
np.array()
np.sum()
np.mean()
np.max()
np.min()
np.any()
np.where()

round()
max()
min()
len()
range()
int()
float()

list comprehension

f-string formatting

class

self
```

---

# Most Important SQL Concepts (Better Learn from DataLemur👀🗿)

```sql
GROUP BY
HAVING
ORDER BY

JOIN
INNER JOIN
LEFT JOIN

AVG()
SUM()
COUNT()
MAX()
MIN()

###learn these definately from Data Lemur : msg by higher sources
ROW_NUMBER()
RANK()
DENSE_RANK()

LAG()
LEAD()

CASE WHEN

Subqueries

Window Functions
```

---

# Frequently Asked Analyzer Problems

- Sales Performance Analyzer
- Traffic Analyzer
- Inventory Analyzer
- Weather Analyzer
- Energy Consumption Analyzer
- Student Score Analyzer
- Sensor Data Analyzer
- Hospital Patient Analytics
- Website Traffic Monitor
- Stock Market Trend Analyzer

---

# Question 1: Sales Performance Analyzer

## Methods

- `create_sales_array()`
- `validate_sales_array()`
- `compute_sales_metrics()`
- `classify_sales()`
- `longest_growth_streak()`
- `format_sales_report()`

## Classification

- `>= target → High`
- `< target → Low`

## Solution

```python
import numpy as np

class SalesAnalyzer:

    def create_sales_array(self, sales_list):
        return np.array(
            sales_list,
            dtype=np.float64
        )

    def validate_sales_array(self, sales_array):

        if sales_array.size == 0:
            return False

        if np.any(sales_array < 0):
            return False

        return True

    def compute_sales_metrics(self, sales_array):

        total = np.sum(sales_array)

        average = round(
            float(np.mean(sales_array)),
            2
        )

        peak = np.max(sales_array)

        return (
            total,
            average,
            peak
        )

    def classify_sales(self, sales_array, target):

        return np.where(
            sales_array >= target,
            "High",
            "Low"
        )

    def longest_growth_streak(self, sales_array):

        longest = 1
        current = 1

        for i in range(1, len(sales_array)):

            if sales_array[i] > sales_array[i - 1]:
                current += 1

            else:
                longest = max(
                    longest,
                    current
                )
                current = 1

        longest = max(
            longest,
            current
        )

        return longest

    def format_sales_report(self, sales_array):

        return np.array(
            [
                f"{int(value)} units"
                for value in sales_array
            ]
        )
```

---

# Question 2: Website Traffic Analyzer

## Methods

- `create_traffic_array()`
- `validate_traffic_array()`
- `compute_traffic_metrics()`
- `classify_traffic()`
- `longest_growth_streak()`
- `format_traffic_report()`

## Classification

- `>= target → Busy`
- `< target → Normal`

## Solution

```python
import numpy as np

class WebsiteTrafficAnalyzer:

    def create_traffic_array(self, visitor_list):

        return np.array(
            visitor_list,
            dtype=np.float64
        )

    def validate_traffic_array(self, traffic_array):

        if traffic_array.size == 0:
            return False

        if np.any(traffic_array < 0):
            return False

        return True

    def compute_traffic_metrics(self, traffic_array):

        total = np.sum(traffic_array)

        average = round(
            float(np.mean(traffic_array)),
            2
        )

        peak = np.max(traffic_array)

        return (
            total,
            average,
            peak
        )

    def classify_traffic(self, traffic_array, target):

        return np.where(
            traffic_array >= target,
            "Busy",
            "Normal"
        )

    def longest_growth_streak(self, traffic_array):

        longest = 1
        current = 1

        for i in range(1, len(traffic_array)):

            if traffic_array[i] > traffic_array[i - 1]:
                current += 1

            else:
                longest = max(
                    longest,
                    current
                )
                current = 1

        longest = max(
            longest,
            current
        )

        return longest

    def format_traffic_report(self, traffic_array):

        return np.array(
            [
                f"{int(v)} visitors"
                for v in traffic_array
            ]
        )
```

---

# Question 3: Student Score Analyzer

## Classification

- `>= target → Pass`
- `< target → Fail`

## Solution

```python
import numpy as np

def classify_scores(score_array, target):

    return np.where(
        score_array >= target,
        "Pass",
        "Fail"
    )
```

---

# Question 4: Weather Analyzer

## Classification

- `>= threshold → Hot`
- `< threshold → Cold`

## Solution

```python
import numpy as np

def classify_weather(temp_array, threshold):

    return np.where(
        temp_array >= threshold,
        "Hot",
        "Cold"
    )
```

---

# Question 5: Inventory Analyzer

## Classification

- `>= target → Sufficient`
- `< target → Low Stock`

## Solution

```python
import numpy as np

def classify_inventory(stock_array, target):

    return np.where(
        stock_array >= target,
        "Sufficient",
        "Low Stock"
    )
```

---

# Concepts Covered

- `np.array()`
- `dtype=np.float64`
- `.size`
- `np.any()`
- `np.sum()`
- `np.mean()`
- `np.max()`
- `round()`
- `np.where()`
- `range()`
- `len()`
- `max()`
- List Comprehension
- f-Strings
- Classes and Methods
- OOP Basics

These five analyzers follow nearly identical hidden-test patterns and are among the most common IAMNEO / Examly questions.

# Conclusion

Master these patterns and functions and you can solve around **80–90% of IAMNEO / Examly / NeoColab Python (NumPy + OOP) and SQL assessments**.

Good luck with your LTM Milestone preparation! 🚀