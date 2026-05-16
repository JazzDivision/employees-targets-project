-- Employees csv imported and table auto-created 

-- Check that the expected number of rows is present (154)
SELECT COUNT(*) FROM clean_employees;

-- Explore the data 
SELECT * FROM clean_employees;

-- Check that data looks as expected
SELECT
    TOP 5 *
FROM clean_employees
ORDER BY employee_id;

-- Check that there are no duplicates, no NULL IDs and there is an expected number of distinct IDs
SELECT
    COUNT(*) AS total_rows,
    COUNT(employee_id) AS non_null_ids,
    COUNT(DISTINCT employee_id) AS distinct_ids
FROM clean_employees;

-- Confirm no NULL employee IDs
SELECT *
FROM clean_employees
WHERE employee_id IS NULL;