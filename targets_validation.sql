-- Targets sanity checks

-- Check for expected number of rows, non-NULL employee IDs & distinct employee IDs (154) in targets table
SELECT
    COUNT(*) AS total_rows,
    COUNT(employee_id) AS non_null_ids,
    COUNT(DISTINCT employee_id) AS distinct_ids
FROM targets;

-- Checking for NULL employee_ids, annual_targets and target_years
SELECT *
FROM targets
WHERE employee_id IS NULL
   OR annual_target IS NULL
   OR target_year IS NULL;

-- Check range of target values to weed out negatives or outliers
SELECT
    MIN(annual_target) AS min_target,
    MAX(annual_target) AS max_target
FROM targets;

-- Checking year consistency e.g. 2026
SELECT DISTINCT target_year
FROM targets;

-- Join validation 

-- Check for any targets without employees aligned 
SELECT
    t.employee_id
FROM targets AS t
LEFT JOIN clean_employees AS e 
ON t.employee_id = e.employee_id
WHERE e.employee_id IS NULL;

-- Checking for expected row count (154) after joining tables, to ensure no duplicates or missing matches
SELECT COUNT(*)
FROM clean_employees AS e
INNER JOIN targets AS t
ON e.employee_id = t.employee_id;