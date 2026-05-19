# Employees & Targets DE Project

## Overview

This project was developed to simulate a simple data engineering workflow, from raw data ingestion to analysis. Raw employee and target data in csv files were sourced, cleaned in Python, then modelled/queried in SQL.

The focus of this project was to transform raw data into something reliable and structured for analysis, before it can be used to answer business questions such as which teams are exceeding target, average target per employee by team, how many employees there are per team, and so on.

By building this project, I wanted to deepen my understanding of ETL concepts in practice and take a practical approach to handling real-world data issues, such as data quality problems, type inconsistencies, and validation during loading.

---

## Data Flow Overview

Raw employees data (CSV)
        ↓
Python cleaning (standardisation & validation)
        ↓
clean_employees table (SQL-ready dataset)
        ↓
Employees & targets relational tables created    
        ↓
Validation checks on clean_employees & targets data        
        ↓
SQL queries & analysis (INNER JOIN, LEFT JOIN, aggregation, filtering, grouping etc.)

---

## Data Sources

### Employees
- Source: employee data pulled from a shared team spreadsheet (names changed to maintain data privacy)
- Grain: one row per employee

Issues identified:
  
  - Inconsistent formatting
  - Missing and duplicate values from trailing spreadsheet data

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
- Handled missing values
- Ensured a stable primary key (`employee_id`)

This step ensured the dataset was consistent, structured, and suitable for relational modelling.

---

### 2. Data Modelling & Querying in SQL

Once cleaned, the data was loaded into SQL for modelling and analysis.

Key tasks:

- Created relational tables
- Extensive preliminary validation checks i.e. duplicate keys, NULL/blank checks, join compatibility, row counts before & after joins
- Joined employees and targets using `employee_id`
- Applied aggregations such as `COUNT`, `SUM`, `AVG`, `MIN` & `MAX` plus subqueries
- Grouped results by attributes such as `team`
- Applied filtering using `GROUP BY`, `WHERE` & `HAVING`
- Categorised data using `CASE`

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
- Sanity checks in SQL before analysis

---

## Examples of Business Questions Answered

- Which employees were tracking below/above average target
- Smallest and largest target values per team
- Number of employees per office
- Categorising targets into low, medium & high bands
- Teams with targets above a certain threshold
- Total target value per team

And so on.

---

## What I Learned

- The importance of clean, well-structured data before analysis  
- How poor data quality, such as missing values & formatting issues, impacts downstream use  
- How joins and aggregation interact in SQL  
- When Python adds value in a pipeline vs when SQL is sufficient
- Combining functions to create single, powerful queries e.g. CASE and GROUP BY
- How to take raw data, transform it into something reliable, then load it for analysis

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

- Extend the dataset to include time-based data, to explore trends rather than just static totals
- Structure it more like a repeatable pipeline rather than separate steps
- In this project, Python acted as the staging layer for data cleaning. However, in a production environment, it may be better handled within the data platform (SQL) itself - for a more repeatable, consolidated structure
