# Data Analytics & OOP Practice Assessments (IAMNEO / Examly Pattern)

This repository contains programming assessments focused on **Object-Oriented Programming (OOP)**, **NumPy**, and **Pandas** for data engineering and analytics validations.

---

# 📋 Table of Contents

1. Core Challenge 1: Daily Energy Usage Analyzer (NumPy)
2. Core Challenge 2: Daily Water Consumption Analyzer (NumPy)
3. Core Challenge 3: Library Book Circulation Analyzer (OOP Dictionaries)
4. Core Challenge 4: Electric Vehicle Charging Analyzer (Pandas)
5. Core Challenge 5: Air Quality Monitoring Analyzer (Pandas)
6. Core Challenge 6: Hospital Patient Visit Analyzer (Pandas)
7. Alternative Domain Frameworks
8. Newly Generated Practice Questions

---

# Core Challenge 1: Daily Energy Usage Analyzer (NumPy)

## Problem Statement

A facilities team logs electricity consumption over a sequence of periods. They need a system to validate data, compute statistics, classify usage levels, detect consecutive high-demand streaks, and generate reports.

## Objective

Implement a class named `EnergyAnalyzer` using NumPy.

## Class Structure

```python
class EnergyAnalyzer:
    pass
```

## Method Specifications

### 1. create_usage_array(self, usage_list)

Converts a list into a NumPy array using `float64`.

Returns:

```python
numpy.ndarray
```

### 2. validate_usage_array(self, usage_array)

Returns `False` if:

* Array is empty
* Any value is negative

Returns:

```python
bool
```

### 3. compute_usage_metrics(self, usage_array)

Computes:

* Minimum value
* Average rounded to 2 decimals
* Spread = max − min

Returns:

```python
(lowest, average, spread)
```

### 4. classify_usage(self, usage_array, low_limit, high_limit)

Rules:

| Condition                       | Category |
| ------------------------------- | -------- |
| value >= high_limit             | High     |
| low_limit <= value < high_limit | Moderate |
| value < low_limit               | Low      |

Returns:

```python
numpy.ndarray
```

### 5. longest_high_usage_streak(self, usage_array, target)

Finds longest consecutive sequence where:

```python
value >= target
```

Returns:

```python
int
```

### 6. format_usage_report(self, usage_array)

Converts values into:

```text
"<value> kWh"
```

Returns:

```python
numpy.ndarray
```

## Reference Solution

```python
import numpy as np

class EnergyAnalyzer:

    def create_usage_array(self, usage_list):
        return np.array(usage_list, dtype=np.float64)

    def validate_usage_array(self, usage_array):
        if usage_array.size == 0:
            return False

        if np.any(usage_array < 0):
            return False

        return True

    def compute_usage_metrics(self, usage_array):
        lowest = int(np.min(usage_array))
        average = round(float(np.mean(usage_array)), 2)
        spread = int(np.max(usage_array) - np.min(usage_array))

        return (lowest, average, spread)

    def classify_usage(self, usage_array, low_limit, high_limit):
        result = []

        for value in usage_array:
            if value >= high_limit:
                result.append("High")
            elif value >= low_limit:
                result.append("Moderate")
            else:
                result.append("Low")

        return np.array(result)

    def longest_high_usage_streak(self, usage_array, target):
        current = 0
        longest = 0

        for value in usage_array:
            if value >= target:
                current += 1
                longest = max(longest, current)
            else:
                current = 0

        return longest

    def format_usage_report(self, usage_array):
        return np.array(
            [f"{int(value)} kWh" for value in usage_array]
        )
```

---

# Core Challenge 2: Daily Water Consumption Analyzer (NumPy)

## Reference Solution

```python
import numpy as np

class WaterAnalyzer:

    def create_consumption_array(self, consumption_list):
        return np.array(consumption_list, dtype=np.float64)

    def validate_consumption_array(self, consumption_array):
        if len(consumption_array) == 0 or np.any(consumption_array < 0):
            return False
        return True

    def compute_consumption_metrics(self, consumption_array):
        minimum = int(np.min(consumption_array))
        average = round(float(np.mean(consumption_array)), 2)
        c_range = int(np.max(consumption_array) - np.min(consumption_array))

        return (minimum, average, c_range)

    def classify_consumption(self, consumption_array, low_limit, high_limit):
        result = []

        for value in consumption_array:
            if value >= high_limit:
                result.append("Excessive")
            elif value >= low_limit:
                result.append("Normal")
            else:
                result.append("Low")

        return np.array(result)

    def longest_excessive_streak(self, consumption_array, threshold):
        current = 0
        longest = 0

        for value in consumption_array:
            if value >= threshold:
                current += 1
                longest = max(longest, current)
            else:
                current = 0

        return longest

    def generate_consumption_report(self, consumption_array):
        return np.array([f"{int(x)} Liters" for x in consumption_array])
```

---

# Core Challenge 3: Library Book Circulation Analyzer (OOP)

```python
class LibraryAnalyzer:

    def __init__(self, books):
        self.books = books

    def average_borrows(self):
        return {
            title: float(sum(info['borrows']) / len(info['borrows']))
            if info['borrows'] else 0.0
            for title, info in self.books.items()
        }

    def genre_counts(self):
        counts = {}

        for info in self.books.values():
            counts[info['genre']] = counts.get(info['genre'], 0) + 1

        return counts

    def total_borrows(self):
        return {
            title: sum(info['borrows'])
            for title, info in self.books.items()
        }

    def most_borrowed_book(self):
        totals = self.total_borrows()

        max_title = None
        max_val = -1

        for title, total in totals.items():
            if total > max_val:
                max_val = total
                max_title = title

        return max_title
```

---

# Core Challenge 4: Electric Vehicle Charging Analyzer (Pandas)

```python
import pandas as pd

def load_and_clean_data(stations_path, sessions_path):

    stations_df = pd.read_csv(stations_path)
    sessions_df = pd.read_csv(sessions_path)

    sessions_df = sessions_df.dropna(subset=['DurationMinutes'])

    return stations_df, sessions_df


def clean_duration_values(sessions_df):

    sessions_df['DurationMinutes'] = pd.to_numeric(
        sessions_df['DurationMinutes']
    )

    sessions_df = sessions_df[
        sessions_df['DurationMinutes'] >= 0
    ]

    return sessions_df


def merge_sessions_with_zones(stations_df, sessions_df):

    return pd.merge(
        sessions_df,
        stations_df,
        on='StationID',
        how='inner'
    )


def detect_high_activity_days(merged_df, threshold):

    daily = (
        merged_df
        .groupby('Date')['DurationMinutes']
        .sum()
        .reset_index()
    )

    qualifying = daily[
        daily['DurationMinutes'] > threshold
    ].sort_values(by='Date')

    return qualifying['Date'].tolist()


def zone_wise_average_duration(merged_df):

    zone_avg = (
        merged_df
        .groupby('Zone')['DurationMinutes']
        .mean()
        .round(2)
        .sort_values(ascending=False)
    )

    return zone_avg.to_dict()


def peak_activity_day(merged_df):

    daily = merged_df.groupby(
        'Date'
    )['DurationMinutes'].sum()

    return str(daily.idxmax())
```

---

# Core Challenge 5: Air Quality Monitoring Analyzer (Pandas)

Same structure as EV Charging Analyzer.

Replace:

```python
DurationMinutes → AQI
StationID → SensorID
```

Functions:

```python
load_and_clean_data()
clean_aqi_values()
merge_sensor_readings()
high_pollution_days()
zone_wise_average_aqi()
peak_pollution_day()
```

---

# Core Challenge 6: Hospital Patient Visit Analyzer (Pandas)

Replace:

```python
DurationMinutes → VisitDuration
Zone → Department
StationID → PatientID
```

Functions:

```python
load_and_clean_data()
clean_visit_duration()
merge_patient_visits()
high_load_days()
department_wise_average_duration()
busiest_day()
```

---

# Alternative Domain Frameworks

| Analyzer                  | Category Key | List Key  |
| ------------------------- | ------------ | --------- |
| PharmacyStockAnalyzer     | category     | restocks  |
| SportsPerformanceAnalyzer | team         | scores    |
| HotelBookingAnalyzer      | category     | bookings  |
| ElectricityAnalyzer       | zone         | usage     |
| CustomerPurchaseAnalyzer  | membership   | purchases |
| CoursePerformanceAnalyzer | department   | marks     |
| StreamingAnalyzer         | genre        | views     |
| FitnessActivityAnalyzer   | membership   | workouts  |

All follow:

```python
average_xxx()
category_counts()
total_xxx()
top_xxx()
```

---

# Newly Generated Practice Questions

## Warehouse Logistics Dispatch Analyzer

```python
import numpy as np

class LogisticsAnalyzer:

    def create_weight_array(self, weight_list):
        return np.array(weight_list, dtype=np.float64)

    def validate_weight_array(self, weight_array):
        return weight_array.size > 0 and not np.any(weight_array < 0)

    def compute_weight_metrics(self, weight_array):
        return (
            int(np.min(weight_array)),
            round(float(np.mean(weight_array)), 2),
            int(np.max(weight_array)-np.min(weight_array))
        )

    def classify_packages(self, weight_array, low_bound, high_bound):
        return np.array([
            "Heavy" if x >= high_bound
            else "Standard" if x >= low_bound
            else "Light"
            for x in weight_array
        ])

    def longest_peak_dispatch_streak(self, weight_array, threshold):

        curr = longest = 0

        for val in weight_array:
            curr = curr + 1 if val >= threshold else 0
            longest = max(longest, curr)

        return longest

    def generate_manifest_report(self, weight_array):
        return np.array(
            [f"{int(x)} kg" for x in weight_array]
        )
```

---

## Server Data Stream Throughput Analyzer

```python
import pandas as pd

def ingest_base_telemetry(servers_path, telemetry_path):

    srv_df = pd.read_csv(servers_path)

    tel_df = pd.read_csv(
        telemetry_path
    ).dropna(subset=['ThroughputMbps'])

    return srv_df, tel_df


def filter_anomaly_signals(telemetry_df):

    telemetry_df['ThroughputMbps'] = pd.to_numeric(
        telemetry_df['ThroughputMbps']
    )

    return telemetry_df[
        telemetry_df['ThroughputMbps'] >= 0
    ]


def combine_datacenter_assets(servers_df, telemetry_df):

    return pd.merge(
        telemetry_df,
        servers_df,
        on='ServerID',
        how='inner'
    )


def capture_overload_windows(joined_df, limit_bound):

    daily = joined_df.groupby(
        'Timestamp'
    )['ThroughputMbps'].sum().reset_index()

    return daily[
        daily['ThroughputMbps'] > limit_bound
    ].sort_values(
        by='Timestamp'
    )['Timestamp'].tolist()


def extract_datacenter_efficiencies(joined_df):

    res = (
        joined_df
        .groupby('DataCenter')['ThroughputMbps']
        .mean()
        .round(2)
        .sort_values(ascending=False)
    )

    return res.to_dict()


def identify_peak_stress_moment(joined_df):

    return str(
        joined_df.groupby(
            'Timestamp'
        )['ThroughputMbps'].sum().idxmax()
    )
```

##Today's pandas question's solution 

```python
import pandas as pd


def load_and_clean_data(households_path, usage_path):
    households_df = pd.read_csv(households_path)
    usage_df = pd.read_csv(usage_path)
    usage_df = usage_df.dropna(subset=["UsageLiters"])
    return households_df, usage_df


def clean_usage_values(usage_df):
    usage_df["UsageLiters"] = usage_df["UsageLiters"].astype(float)
    usage_df = usage_df[usage_df["UsageLiters"] >= 0]
    return usage_df


def merge_usage_with_zones(households_df, usage_df):
    merged_df = pd.merge(
        usage_df, households_df, on="HouseholdID", how="inner"
    )
    return merged_df


def detect_high_usage_days(merged_df, threshold):
    daily_totals = (
        merged_df.groupby("Date")["UsageLiters"].sum().reset_index()
    )

    result = (
        daily_totals[daily_totals["UsageLiters"] > threshold]["Date"]
        .sort_values()
        .tolist()
    )
    return result


def zone_wise_average_usage(merged_df):
    result = (
        merged_df.groupby("Zone")["UsageLiters"]
        .mean()
        .round(2)
        .sort_values(ascending=False)
        .to_dict()
    )
    return result


def peak_usage_day(merged_df):
    daily_totals = merged_df.groupby("Date")["UsageLiters"].sum()
    return daily_totals.idxmax()

```
