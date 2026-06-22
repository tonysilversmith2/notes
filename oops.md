Here is a complete, structured **README.md** file containing all the original problem statements, detailed specifications, reference solutions, and additional practice questions tailored to the same assessment pattern.

---

# Data Analytics & OOP Practice Assessments (IAMNEO / Examly Pattern)

This repository contains programming assessments focused on **Object-Oriented Programming (OOP)**, **NumPy**, and **Pandas** for data engineering and analytics validations.

---

## 📋 Table of Contents

1. [Core Challenge 1: Daily Energy Usage Analyzer (NumPy)](#core-challenge-1-daily-energy-usage-analyzer-numpy)
2. [Core Challenge 2: Daily Water Consumption Analyzer (NumPy)](#core-challenge-2-daily-water-consumption-analyzer-numpy)
3. [Core Challenge 3: Library Book Circulation Analyzer (OOP Dictionaries)](#core-challenge-3-library-book-circulation-analyzer-oop-dictionaries)
4. [Core Challenge 4: Electric Vehicle Charging Analyzer (Pandas)](#core-challenge-4-electric-vehicle-charging-analyzer-pandas)
5. [Core Challenge 5: Air Quality Monitoring Analyzer (Pandas)](#core-challenge-5-air-quality-monitoring-analyzer-pandas)
6. [Core Challenge 6: Hospital Patient Visit Analyzer (Pandas)](#core-challenge-6-hospital-patient-visit-analyzer-pandas)
7. [Alternative Domain Frameworks](#alternative-domain-frameworks)
8. [🚀 Newly Generated Practice Questions](#-newly-generated-practice-questions)

---

## Core Challenge 1: Daily Energy Usage Analyzer (NumPy)

### Problem Statement

A facilities team logs the electricity a building consumes over a sequence of time periods (for example, daily kWh readings). They need a tool that can prepare the raw data for analysis, validate it, summarize it with key metrics, classify each period into usage bands, detect the longest streak of high-demand periods, and produce a human-readable report. The data is provided as a 1D sequence of usage values in chronological order.

### Objective

Design and implement a Python class named `EnergyAnalyzer` that uses `NumPy` to perform analytical operations on a 1D usage dataset. You are expected to demonstrate array creation, validation, aggregation, conditional categorization, streak algorithms, and string formatting.

### Class Structure

```python
class EnergyAnalyzer:
    # Note: Do NOT store the array as an instance variable. 
    # Every method receives the required data as an argument.

```



### Method Specifications

#### 1. `create_usage_array(self, usage_list)`

* 
**Description:** Converts an input list into a 1D NumPy array using `float64` dtype.


* 
**Returns:** `numpy.ndarray` 



#### 2. `validate_usage_array(self, usage_array)`

* 
**Validation Rules:** Return `False` if the array is empty or contains any negative values; otherwise, return `True`.


* 
**Returns:** `bool` 



#### 3. `compute_usage_metrics(self, usage_array)`

* 
**Metrics:** * `lowest`: Minimum value 


* 
`average`: Mean rounded to 2 decimals 


* 
`spread`: Maximum − Minimum 




* 
**Returns:** `tuple` -> `(lowest, average, spread)` 



#### 4. `classify_usage(self, usage_array, low_limit, high_limit)`

* 
**Rules:** 


* `value >= high_limit` $\rightarrow$ `'High'`
* `low_limit <= value < high_limit` $\rightarrow$ `'Moderate'`
* `value < low_limit` $\rightarrow$ `'Low'`


* 
**Returns:** `numpy.ndarray` 



#### 5. `longest_high_usage_streak(self, usage_array, target)`

* 
**Logic:** Finds the longest consecutive run of values where `value >= target`.


* 
**Returns:** `int` 



#### 6. `format_usage_report(self, usage_array)`

* 
**Logic:** Converts each value into a string formatted as `"<value> kWh"`, where `<value>` is the integer representation.


* 
**Returns:** `numpy.ndarray` 



### Reference Solution

```python
import numpy as np

class EnergyAnalyzer:
    def create_usage_array(self, usage_list):
        [cite_start]return np.array(usage_list, dtype=np.float64) [cite: 33]
        
    def validate_usage_array(self, usage_array):
        [cite_start]if usage_array.size == 0: [cite: 33]
            [cite_start]return False [cite: 33]
        [cite_start]if np.any(usage_array < 0): [cite: 33]
            [cite_start]return False [cite: 33]
        [cite_start]return True [cite: 33]
        
    def compute_usage_metrics(self, usage_array):
        [cite_start]lowest = int(np.min(usage_array)) [cite: 33, 34]
        [cite_start]average = round(float(np.mean(usage_array)), 2) [cite: 34]
        [cite_start]spread = int(np.max(usage_array) - np.min(usage_array)) [cite: 34]
        [cite_start]return (lowest, average, spread) [cite: 34]
        
    def classify_usage(self, usage_array, low_limit, high_limit):
        [cite_start]result = [] [cite: 34]
        [cite_start]for value in usage_array: [cite: 34]
            [cite_start]if value >= high_limit: [cite: 34]
                [cite_start]result.append("High") [cite: 34]
            [cite_start]elif value >= low_limit: [cite: 34, 35]
                [cite_start]result.append("Moderate") [cite: 35]
            [cite_start]else: [cite: 35]
                [cite_start]result.append("Low") [cite: 35]
        [cite_start]return np.array(result) [cite: 35]
        
    def longest_high_usage_streak(self, usage_array, target):
        [cite_start]current = 0 [cite: 35]
        [cite_start]longest = 0 [cite: 35]
        [cite_start]for value in usage_array: [cite: 35, 36]
            [cite_start]if value >= target: [cite: 36]
                [cite_start]current += 1 [cite: 36]
                [cite_start]longest = max(longest, current) [cite: 36]
            [cite_start]else: [cite: 36]
                [cite_start]current = 0 [cite: 36]
        [cite_start]return longest [cite: 36]
        
    def format_usage_report(self, usage_array):
        [cite_start]return np.array( [cite: 36, 37]
            [cite_start][f"{int(value)} kWh" for value in usage_array] [cite: 37]
        [cite_start]) [cite: 37]

```

---

## Core Challenge 2: Daily Water Consumption Analyzer (NumPy)

### Problem Statement

A residential society records daily water consumption (in liters) for conservation monitoring. The management needs a system to validate records, calculate metrics, classify usage levels, identify periods of excessive consumption streaks, and generate reports. The data arrives as a 1D sequence in chronological order.

### Objective

Implement `WaterAnalyzer` using NumPy to handle calculations dynamically without storing instance attributes.

```python
class WaterAnalyzer:
    def create_consumption_array(self, consumption_list):
        import numpy as np
        [cite_start]return np.array(consumption_list, dtype=np.float64) [cite: 45]

    def validate_consumption_array(self, consumption_array):
        import numpy as np
        if len(consumption_array) == 0 or np.any(consumption_array < 0):
            return False
        return True

    def compute_consumption_metrics(self, consumption_array):
        import numpy as np
        minimum = int(np.min(consumption_array))
        average = round(float(np.mean(consumption_array)), 2)
        c_range = int(np.max(consumption_array) - np.min(consumption_array))
        return (minimum, average, c_range)

    def classify_consumption(self, consumption_array, low_limit, high_limit):
        import numpy as np
        result = []
        for value in consumption_array:
            [cite_start]if value >= high_limit: [cite: 49]
                [cite_start]result.append("Excessive") [cite: 49]
            [cite_start]elif value >= low_limit: [cite: 49]
                [cite_start]result.append("Normal") [cite: 49]
            [cite_start]else: [cite: 49]
                [cite_start]result.append("Low") [cite: 49]
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
        import numpy as np
        return np.array([f"{int(x)} Liters" for x in consumption_array])

```

---

## Core Challenge 3: Library Book Circulation Analyzer (OOP Dictionaries)

### Problem Statement

A public library tracks its books' monthly borrowing history across multiple genres. To replace manual tracking, the library requires a system that manages metadata and extracts insights through specific dictionary operations.

### Objective

Implement `LibraryAnalyzer` to handle nested data structures, computing metrics while strict constraints dictate tie-breaking logic and attribute persistence.

```python
class LibraryAnalyzer:
    def __init__(self, books: dict):
        # Store provided book data preserving insertion order
        [cite_start]self.books = books [cite: 61, 62]

    def average_borrows(self) -> dict:
        # Maps book_title -> average monthly borrow count (float)
        return {title: float(sum(info['borrows']) / len(info['borrows'])) if info['borrows'] else 0.0 
                [cite_start]for title, info in self.books.items()} [cite: 63, 64]

    def genre_counts(self) -> dict:
        # Maps genre -> count of books
        [cite_start]counts = {} [cite: 64, 65]
        for info in self.books.values():
            counts[info['genre']] = counts.get(info['genre'], 0) + 1
        return counts

    def total_borrows(self) -> dict:
        # Maps book_title -> total borrow count
        [cite_start]return {title: sum(info['borrows']) for title, info in self.books.items()} [cite: 65, 66]

    def most_borrowed_book(self) -> str:
        # Returns book title with maximum total borrows. Resolve ties by original order.
        [cite_start]totals = self.total_borrows() [cite: 66, 67]
        max_title = None
        max_val = -1
        [cite_start]for title, total in totals.items(): [cite: 67]
            [cite_start]if total > max_val: [cite: 67]
                [cite_start]max_val = total [cite: 67]
                [cite_start]max_title = title [cite: 67]
        [cite_start]return max_title [cite: 68]

```

---

## Core Challenge 4: Electric Vehicle Charging Analyzer (Pandas)

### Problem Statement

A transportation department manages city station registries (`ChargingStations.csv`) and activities (`ChargingSessions.csv`). Records occasionally contain missing durations, negative entries, or unregistered station IDs that require programmatic handling.

### Implementation Code

```python
import pandas as pd

def load_and_clean_data(stations_path, sessions_path):
    [cite_start]stations_df = pd.read_csv(stations_path) [cite: 93]
    [cite_start]sessions_df = pd.read_csv(sessions_path) [cite: 93]
    [cite_start]sessions_df = sessions_df.dropna(subset=['DurationMinutes']) [cite: 94]
    [cite_start]return stations_df, sessions_df [cite: 95]

def clean_duration_values(sessions_df):
    [cite_start]sessions_df['DurationMinutes'] = pd.to_numeric(sessions_df['DurationMinutes']) [cite: 95]
    [cite_start]sessions_df = sessions_df[sessions_df['DurationMinutes'] >= 0] [cite: 96]
    return sessions_df

def merge_sessions_with_zones(stations_df, sessions_df):
    [cite_start]return pd.merge(sessions_df, stations_df, on='StationID', how='inner') [cite: 97, 98]

def detect_high_activity_days(merged_df, threshold):
    [cite_start]daily = merged_df.groupby('Date')['DurationMinutes'].sum().reset_index() [cite: 98]
    [cite_start]qualifying = daily[daily['DurationMinutes'] > threshold].sort_values(by='Date') [cite: 99]
    [cite_start]return qualifying['Date'].tolist() [cite: 99]

def zone_wise_average_duration(merged_df):
    [cite_start]zone_avg = merged_df.groupby('Zone')['DurationMinutes'].mean() [cite: 100]
    [cite_start]zone_avg = zone_avg.round(2).sort_values(ascending=False) [cite: 100]
    [cite_start]return zone_avg.to_dict() [cite: 101]

def peak_activity_day(merged_df):
    [cite_start]daily = merged_df.groupby('Date')['DurationMinutes'].sum() [cite: 101]
    [cite_start]return str(daily.idxmax()) [cite: 102]

```

---

## Core Challenge 5: Air Quality Monitoring Analyzer (Pandas)

### Problem Statement

An environmental department requires a processing engine to clean and merge cross-referenced telemetry files (`Sensors.csv`, `AQIReadings.csv`) to track air quality metrics while purging faulty or unregistered readings.

### Implementation Code

```python
import pandas as pd

def load_and_clean_data(sensor_path, aqi_path):
    [cite_start]sensors_df = pd.read_csv(sensor_path) [cite: 121]
    [cite_start]aqi_df = pd.read_csv(aqi_path).dropna(subset=['AQI']) [cite: 121]
    return sensors_df, aqi_df

def clean_aqi_values(aqi_df):
    [cite_start]aqi_df['AQI'] = pd.to_numeric(aqi_df['AQI']) [cite: 121]
    [cite_start]return aqi_df[aqi_df['AQI'] >= 0] [cite: 122]

def merge_sensor_readings(sensors_df, aqi_df):
    [cite_start]return pd.merge(aqi_df, sensors_df, on='SensorID', how='inner') [cite: 122]

def high_pollution_days(merged_df, threshold):
    [cite_start]daily = merged_df.groupby('Date')['AQI'].sum().reset_index() [cite: 122]
    [cite_start]return daily[daily['AQI'] > threshold].sort_values(by='Date')['Date'].tolist() [cite: 123]

def zone_wise_average_aqi(merged_df):
    [cite_start]zone_avg = merged_df.groupby('Zone')['AQI'].mean().round(2).sort_values(ascending=False) [cite: 123]
    [cite_start]return zone_avg.to_dict() [cite: 124]

def peak_pollution_day(merged_df):
    [cite_start]return str(merged_df.groupby('Date')['AQI'].sum().idxmax()) [cite: 124]

```

---

## Core Challenge 6: Hospital Patient Visit Analyzer (Pandas)

### Problem Statement

A clinical administration tracker validates structural system integrity across logs (`Patients.csv`, `VisitLogs.csv`) by cleansing missing variables and filtering anomalies.

### Implementation Code

```python
import pandas as pd

def load_and_clean_data(patient_path, visit_path):
    [cite_start]patients_df = pd.read_csv(patient_path) [cite: 134]
    [cite_start]visits_df = pd.read_csv(visit_path).dropna(subset=['VisitDuration']) [cite: 134]
    return patients_df, visits_df

def clean_visit_duration(visits_df):
    [cite_start]visits_df['VisitDuration'] = pd.to_numeric(visits_df['VisitDuration']) [cite: 134]
    [cite_start]return visits_df[visits_df['VisitDuration'] >= 0] [cite: 134]

def merge_patient_visits(patients_df, visits_df):
    [cite_start]return pd.merge(visits_df, patients_df, on='PatientID', how='inner') [cite: 135]

def high_load_days(merged_df, threshold):
    [cite_start]daily = merged_df.groupby('Date')['VisitDuration'].sum().reset_index() [cite: 135]
    [cite_start]return daily[daily['VisitDuration'] > threshold].sort_values(by='Date')['Date'].tolist() [cite: 135, 136]

def department_wise_average_duration(merged_df):
    [cite_start]dept_avg = merged_df.groupby('Department')['VisitDuration'].mean().round(2).sort_values(ascending=False) [cite: 136]
    [cite_start]return dept_avg.to_dict() [cite: 136]

def busiest_day(merged_df):
    [cite_start]return str(merged_df.groupby('Date')['VisitDuration'].sum().idxmax()) [cite: 137]

```

---

## Alternative Domain Frameworks

These schemas represent structured OOP profiles built for key-value aggregation mappings.

| Analyzer Target Class | Structural Key | Collection List Property | Method Bindings |
| --- | --- | --- | --- |
| <br>`PharmacyStockAnalyzer` 

 | <br>`"category"` 

 | <br>`"restocks"` 

 | <br>`average_restock()`, `category_counts()`, `total_restock()`, `most_stocked_medicine()` 

 |
| <br>`SportsPerformanceAnalyzer` 

 | <br>`"team"` 

 | <br>`"scores"` 

 | <br>`average_scores()`, `team_counts()`, `total_scores()`, `top_player()` 

 |
| <br>`HotelBookingAnalyzer` 

 | <br>`"category"` 

 | <br>`"bookings"` 

 | <br>`average_bookings()`, `category_counts()`, `total_bookings()`, `most_booked_room()` 

 |
| <br>`ElectricityAnalyzer` 

 | <br>`"zone"` 

 | <br>`"usage"` 

 | <br>`average_usage()`, `zone_counts()`, `total_usage()`, `highest_consumption_household()` 

 |
| <br>`CustomerPurchaseAnalyzer` 

 | <br>`"membership"` 

 | <br>`"purchases"` 

 | <br>`average_purchase()`, `membership_counts()`, `total_spending()`, `top_customer()` 

 |
| <br>`CoursePerformanceAnalyzer` 

 | <br>`"department"` 

 | <br>`"marks"` 

 | <br>`average_marks()`, `department_counts()`, `total_marks()`, `top_student()` 

 |
| <br>`StreamingAnalyzer` 

 | <br>`"genre"` 

 | <br>`"views"` 

 | <br>`average_views()`, `genre_counts()`, `total_views()`, `most_watched_movie()` 

 |
| <br>`FitnessActivityAnalyzer` 

 | <br>`"membership"` 

 | <br>`"workouts"` 

 | <br>`average_workout_duration()`, `membership_counts()`, `total_workout_duration()`, `most_active_member()` 

 |

---

## 🚀 Newly Generated Practice Questions

### 1. Warehouse Logistics Dispatch Analyzer (NumPy)

#### Problem Statement

A logistics management dashboard tracks individual delivery package weights processed hourly per facility terminal. They require a data management toolkit to convert these tracking sequences, weed out recording failures, verify outspread metrics, tag load capacity groups, isolate consecutive high-intensity shipping periods, and provide a normalized output manifest.

#### Objective

Design and implement an explicit Python structure class named `LogisticsAnalyzer` running native vector `NumPy` processes without mutating object instance declarations.

#### Method Interface Requirements

* **`create_weight_array(self, weight_list)`**: Converts incoming items to explicit standard `float64` vectors.
* **`validate_weight_array(self, weight_array)`**: Returns `False` if payload length evaluated equals zero or contains negative numbers.
* **`compute_weight_metrics(self, weight_array)`**: Extracts minimum element, mean value rounded up to two decimal metrics, and absolute tracking dispersion span (`max - min`).
* **`classify_packages(self, weight_array, low_bound, high_bound)`**: Tags individual entities matching conditional criteria:
* $\text{weight} \ge \text{high\_bound} \rightarrow \text{"Heavy"}$
* $\text{low\_bound} \le \text{weight} < \text{high\_bound} \rightarrow \text{"Standard"}$
* $\text{weight} < \text{low\_bound} \rightarrow \text{"Light"}$


* **`longest_peak_dispatch_streak(self, weight_array, threshold)`**: Evaluates longest running continuous array indices where absolute measurement matches or exceeds targeted limits.
* **`generate_manifest_report(self, weight_array)`**: Generates string elements formatted precisely as `"<int_value> kg"`.

```python
import numpy as np

class LogisticsAnalyzer:
    def create_weight_array(self, weight_list):
        return np.array(weight_list, dtype=np.float64)
        
    def validate_weight_array(self, weight_array):
        return weight_array.size > 0 and not np.any(weight_array < 0)
        
    def compute_weight_metrics(self, weight_array):
        return (int(np.min(weight_array)), round(float(np.mean(weight_array)), 2), int(np.max(weight_array) - np.min(weight_array)))
        
    def classify_packages(self, weight_array, low_bound, high_bound):
        return np.array(["Heavy" if x >= high_bound else "Standard" if x >= low_bound else "Light" for x in weight_array])
        
    def longest_peak_dispatch_streak(self, weight_array, threshold):
        curr = longest = 0
        for val in weight_array:
            curr = curr + 1 if val >= threshold else 0
            longest = max(longest, curr)
        return longest
        
    def generate_manifest_report(self, weight_array):
        return np.array([f"{int(x)} kg" for x in weight_array])

```

---

### 2. server Data Stream Throughput Analyzer (Pandas Inner Join & Aggregation Structure)

#### Problem Statement

An enterprise cloud operations unit tracks cluster deployments via server definitions mapping (`Servers.csv`) cross-referenced against transaction log files (`TelemetryLogs.csv`). Data inputs sometimes present corrupted indicators, blank entries, or tracking calls representing undeployed compute hardware.

#### Schema Profiles

* **`Servers.csv`**: `ServerID` (str), `DataCenter` (str), `HardwareTier` (str)
* **`TelemetryLogs.csv`**: `Timestamp` (str), `ServerID` (str), `ThroughputMbps` (float)

#### Objective

Develop six specific decoupled modular components utilizing data frame workflows via `Pandas` libraries.

```python
import pandas as pd

def ingest_base_telemetry(servers_path, telemetry_path):
    # Action: Ingest files, filter out rows containing missing metrics in 'ThroughputMbps'
    srv_df = pd.read_csv(servers_path)
    tel_df = pd.read_csv(telemetry_path).dropna(subset=['ThroughputMbps'])
    return srv_df, tel_df

def filter_anomaly_signals(telemetry_df):
    # Action: Enforce conversion validation rules, purge structural records displaying negative telemetry values
    telemetry_df['ThroughputMbps'] = pd.to_numeric(telemetry_df['ThroughputMbps'])
    return telemetry_df[telemetry_df['ThroughputMbps'] >= 0]

def combine_datacenter_assets(servers_df, telemetry_df):
    # Action: Implement structural inner relational joins mapping across identifying ServerID keys
    return pd.merge(telemetry_df, servers_df, on='ServerID', how='inner')

def capture_overload_windows(joined_df, limit_bound):
    # Action: Track structural timestamp dates where global collective load strictly breaks bounds
    daily = joined_df.groupby('Timestamp')['ThroughputMbps'].sum().reset_index()
    return daily[daily['ThroughputMbps'] > limit_bound].sort_values(by='Timestamp')['Timestamp'].tolist()

def extract_datacenter_efficiencies(joined_df):
    # Action: Evaluate mean efficiency value categorized by geographical zones, ordered descending, cast to dictionary
    res = joined_df.groupby('DataCenter')['ThroughputMbps'].mean().round(2).sort_values(ascending=False)
    return res.to_dict()

def identify_peak_stress_moment(joined_df):
    # Action: Track isolated structural context holding highest historical workload sum
    return str(joined_df.groupby('Timestamp')['ThroughputMbps'].sum().idxmax())

```
