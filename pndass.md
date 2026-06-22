Here are the complete Python solution scripts utilizing the **Pandas** library for both data analytics projects outlined in the workbook.
## Project 1: Inventory Management Analytics
```python
import pandas as pd


# Task 1: Load and Clean the Inventory Data
def load_and_clean_inventory(inventory_path):
    # 1. [span_0](start_span)Read the CSV file[span_0](end_span)
    df = pd.read_csv(inventory_path)

    # 2. [span_1](start_span)Remove duplicate rows[span_1](end_span)
    df = df.drop_duplicates()

    # 3. [span_2](start_span)Replace any missing Stock value with 0[span_2](end_span)
    df["Stock"] = df["Stock"].fillna(0)

    # 4. [span_3](start_span)Convert the Stock column to an integer type[span_3](end_span)
    df["Stock"] = df["Stock"].astype(int)

    return df


# Task 2: Identify Low-Stock Products
def low_stock_products(inventory_df, threshold):
    # [span_4](start_span)Filter products whose Stock is strictly below the given threshold[span_4](end_span)
    return inventory_df[inventory_df["Stock"] < threshold]


# Task 3: Calculate Inventory Value
def calculate_inventory_value(inventory_df):
    # [span_5](start_span)InventoryValue = Stock x Price[span_5](end_span)
    inventory_df["InventoryValue"] = (
        inventory_df["Stock"] * inventory_df["Price"]
    )
    return inventory_df


# Task 4: Category-wise Summary Report
def category_summary(inventory_df):
    # [span_6](start_span)Group by Category and perform aggregations[span_6](end_span)
    summary_df = (
        inventory_df.groupby("Category")
        .agg(
            TotalStock=("Stock", "sum"),
            AveragePrice=("Price", "mean"),
            TotalInventoryValue=("InventoryValue", "sum"),
        )
        .reset_index()
    )
    return summary_df


# Task 5: Merge Supplier Details
def merge_supplier_details(inventory_df, supplier_df):
    # [span_7](start_span)Combine data sets on matching shared column key "SupplierID"[span_7](end_span)
    return pd.merge(inventory_df, supplier_df, on="SupplierID", how="left")


# Task 6: Find Top Inventory Products
def top_inventory_products(inventory_df, n):
    # [span_8](start_span)[span_9](start_span)Pull out top-N rows based on largest InventoryValue[span_8](end_span)[span_9](end_span)
    return inventory_df.nlargest(n, "InventoryValue")


# Challenge Extensions
def supplier_summary(merged_df):
    # [span_10](start_span)Total inventory value of all products supplied per supplier[span_10](end_span)
    return (
        merged_df.groupby("SupplierName")["InventoryValue"]
        .sum()
        .reset_index(name="TotalInventoryValue")
    )


def category_pivot(inventory_df):
    # [span_11](start_span)Category-wise pivot report reshaping categories into rows[span_11](end_span)
    return inventory_df.pivot_table(
        index="Category",
        values=["Stock", "InventoryValue"],
        aggfunc={"Stock": "sum", "InventoryValue": "sum"},
    )


def stock_ranking(inventory_df):
    # [span_12](start_span)Rank every product by its stock level (highest stock = rank 1)[span_12](end_span)
    inventory_df["StockRank"] = inventory_df["Stock"].rank(
        ascending=False, method="min"
    )
    return inventory_df

```
## Project 2: HR Employee Analytics System
```python
import pandas as pd


# Task 1: Load and Clean the Employee Data
def clean_employee_data(employee_path):
    # 1. [span_13](start_span)Read the CSV file[span_13](end_span)
    df = pd.read_csv(employee_path)

    # 2. [span_14](start_span)Remove duplicate rows[span_14](end_span)
    df = df.drop_duplicates()

    # 3. [span_15](start_span)Replace missing Salary with mean salary[span_15](end_span)
    mean_salary = df["Salary"].mean()
    df["Salary"] = df["Salary"].fillna(mean_salary)

    # 4. [span_16](start_span)Replace missing Experience with 0[span_16](end_span)
    df["Experience"] = df["Experience"].fillna(0)

    # 5. [span_17](start_span)Make sure Salary and Experience are stored as numeric types[span_17](end_span)
    df["Salary"] = pd.to_numeric(df["Salary"])
    df["Experience"] = pd.to_numeric(df["Experience"])

    return df


# Task 2: Department Salary Report
def department_salary_report(employee_df):
    # [span_18](start_span)Group employees by Department and calculate stats[span_18](end_span)
    report_df = (
        employee_df.groupby("Department")
        .agg(
            AvgSalary=("Salary", "mean"),
            MaxSalary=("Salary", "max"),
            MinSalary=("Salary", "min"),
            EmployeeCount=("EmpID", "count"),
        )
        .reset_index()
    )
    return report_df


# Task 3: Filter Experienced Employees
def experienced_employees(employee_df, min_exp):
    # [span_19](start_span)Return employees with experience greater than or equal to min_exp[span_19](end_span)
    return employee_df[employee_df["Experience"] >= min_exp]


# Task 4: Salary Band Classification
def salary_band(employee_df):
    # [span_20](start_span)[span_21](start_span)Apply conditions to label categories[span_20](end_span)[span_21](end_span)
    def assign_band(salary):
        if salary >= 70000:
            return "High"
        elif salary >= 60000:
            return "Medium"
        else:
            return "Low"

    employee_df["SalaryBand"] = employee_df["Salary"].apply(assign_band)
    return employee_df


# Task 5: Top-Paid Employees
def top_paid_employees(employee_df, n):
    # [span_22](start_span)Return top N ears sorted descending[span_22](end_span)
    return employee_df.nlargest(n, "Salary")


# Task 6: Location Summary
def location_summary(employee_df):
    # [span_23](start_span)Group employees by Location[span_23](end_span)
    loc_df = (
        employee_df.groupby("Location")
        .agg(EmployeeCount=("EmpID", "count"), AverageSalary=("Salary", "mean"))
        .reset_index()
    )
    return loc_df


# Task 7: Salary Ranking
def salary_ranking(employee_df):
    # [span_24](start_span)[span_25](start_span)Rank employees where highest salary gets 1st position[span_24](end_span)[span_25](end_span)
    employee_df["SalaryRank"] = employee_df["Salary"].rank(
        ascending=False, method="min"
    )
    return employee_df


# Challenge Extensions
def department_pivot(employee_df):
    # [span_26](start_span)Location-vs-Department pivot table showing employee count[span_26](end_span)
    return employee_df.pivot_table(
        index="Location",
        columns="Department",
        values="EmpID",
        aggfunc="count",
        fillna=0,
    )


def salary_distribution(employee_df):
    # [span_27](start_span)Return how many employees fall into each salary band[span_27](end_span)
    if "SalaryBand" not in employee_df.columns:
        employee_df = salary_band(employee_df)
    return employee_df["SalaryBand"].value_counts().reset_index()


def department_top_employee(employee_df):
    # [span_28](start_span)Find the highest-paid employee within each department[span_28](end_span)
    return employee_df.loc[
        employee_df.groupby("Department")["Salary"].idxmax()
    ]

```
