-- Employees csv imported and table auto-created 

-- Validation checks 

-- Explore the data 
SELECT * FROM clean_employees;

-- Check for expected number of rows, non-NULL employee IDs & distinct employee IDs (154)
SELECT
    COUNT(*) AS total_rows,
    COUNT(employee_id) AS non_null_ids,
    COUNT(DISTINCT employee_id) AS distinct_ids
FROM clean_employees;

-- Confirm no NULL employee IDs
SELECT *
FROM clean_employees
WHERE employee_id IS NULL;

-- Checking for duplicate keys (employee_ids where more than 1 row is counted)
SELECT
    employee_id,
    COUNT(*)
FROM clean_employees
GROUP BY employee_id
HAVING COUNT(*) > 1;

-- Checking for missing employee/team names and empty text being counted as data
SELECT *
FROM clean_employees
WHERE employee_name IS NULL
    OR team IS NULL
    OR employee_name = ''
    OR team = '';

-- Checking for messy spacing i.e. 'Manchester' and 'Manchester ' returning two separate teams
SELECT DISTINCT team
FROM clean_employees;

-- Checking against Python cleaning stage 

-- Checking for NULL dates to see if my Python cleaning step successfully standardised them 
SELECT *
FROM clean_employees
WHERE start_date IS NULL;

-- Check date ranges to catch formatting issues or unrealistic dates
SELECT
    MIN(start_date),
    MAX(start_date)
FROM clean_employees;

-- Join compatibility 

-- Check for any employees with missing targets
SELECT
    e.employee_id
FROM clean_employees AS e -- Take every employee 
LEFT JOIN targets AS t -- For each employee, look for a matching row in targets - if no match, NULL appears
ON e.employee_id = t.employee_id -- Match the rows where employee_id is the same
WHERE t.employee_id IS NULL; -- Specifies that we only want to see rows with NULLs (where a target wasn't present)

-- Checking for expected row count (154) after joining tables, to ensure no duplicates or missing matches
SELECT COUNT(*)
FROM clean_employees AS e
INNER JOIN targets AS t
ON e.employee_id = t.employee_id;