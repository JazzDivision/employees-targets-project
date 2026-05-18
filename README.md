# Employees & Targets DE Project

## Overview
This project demonstrates a simple data engineering workflow, where raw employee data is cleaned using Python, then modelled and queried in SQL.

The focus was on building reliable, structured data before analysis, carefully deciding on tool usage, and applying core concepts such as relational design, joins, and aggregation.

The project reflects a practical approach to handling real-world data issues, including data quality problems, type inconsistencies, and validation during data loading.

---

## Data Sources

### Employees
- Source: employee data pulled from an Excel spreadsheet (names changed to maintain data privacy)
- Grain: one row per employee

Issues identified:
  
  - Inconsistent formatting
  - Missing and duplicate values
  - Columns not suitable for direct joins

### Targets
- Source: Dummy .csv dataset created by me
- One annual target per employee
- Grain: one row per employee per year
- Joined to employees via `employee_id`

---

## Approach

### 1. Data Cleaning in Python
Python (Pandas) was used to prepare the employee dataset for reliable use in SQL.

Key steps:

- Loaded raw CSV data
- Removed empty / invalid rows
- Standardised column formats
- Handled missing values
- Ensured a stable primary key (`employee_id`)

This step ensured the dataset was consistent, structured, and suitable for relational modelling.

---

### 2. Data Modelling & Querying in SQL

Once cleaned, the data was loaded into SQL for modelling and analysis.

Key tasks:

- Created relational tables
- Joined employees and targets using `employee_id`
- Applied aggregations, such as `COUNT`, `SUM` & `AVG`
- Grouped results by attributes such as `team`
- Applied filtering using `WHERE` & `HAVING`

---

## Design Decisions

- Python was used only where transformation and validation were required  
- SQL was used for relational modelling and querying  
- The targets dataset was not processed in Python, as it was already clean and structured

This approach kept the pipeline simple and ensured each tool was used where it adds the most value.

---

## Skills Demonstrated

- Data cleaning and validation using Python (Pandas)
- Identifying and resolving data quality issues
- Relational data modelling and grain awareness
- SQL joins and aggregations
- Writing clear, readable queries
- Making pragmatic tool choices (Python vs SQL)

---

## What I Learned

- The importance of clean, well-structured data before analysis  
- How poor data quality, such as missing values & formatting issues, impacts downstream use  
- How joins and aggregation interact in SQL  
- When Python adds value in a pipeline vs when SQL is sufficient

---

## Challenges & Problem Solving

During this project, I encountered a few practical data issues that required investigation and resolution. These challenges reinforced the importance of careful validation at each stage of a data pipeline, particularly when working with spreadsheet-based source data.

### Handling apparent duplicates in Python
When initially checking for duplicate employee records, Pandas flagged rows with missing `employee_id` values as duplicates.  

On closer inspection, these were not true duplicates but empty rows introduced by the Excel spreadsheet.  

To resolve this:

- I removed fully empty rows before running key validation
- Re-ran duplicate checks to confirm data integrity

---

### Data type inconsistencies
After cleaning, key columns such as `employee_id` and `start_date` were not in the expected formats.

To fix this:

- Converted `employee_id` from float to integer
- Parsed date columns into proper date types

This ensured the dataset could be reliably used in SQL.

---

### Importing data into SQL
On first import, I observed an unexpected row count due to the header being incorrectly treated as data.

I resolved this by:

- Re-importing the dataset with correct header settings
- Validating row counts after loading

---

## Future Improvements

- Introduce time-based analysis for deeper insights (e.g. monthly, quarterly targets etc.)
- Add automated data validation checks
- Expand the dataset to better simulate a real-world pipeline
