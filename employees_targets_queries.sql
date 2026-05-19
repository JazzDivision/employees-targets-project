-- Employees & targets project queries

-- List all employees with their annual targets
SELECT
    e.employee_id, -- Selecting fields
    e. employee_name,
    t.annual_target
FROM clean_employees AS e -- Joining the tables 
INNER JOIN targets AS t
    ON e.employee_id = t.employee_id; -- Specifying the join field 

-- Count the number of employees per team
SELECT
    Team,
    COUNT(*) AS employee_count
FROM clean_employees
GROUP BY Team
ORDER BY employee_count DESC;

-- Discover total target value per team 
SELECT
    team,
    SUM(annual_target) AS team_target_value
FROM clean_employees AS e
INNER JOIN targets AS t
ON e.employee_id = t.employee_id
GROUP BY e.team
ORDER BY team_target_value DESC;

-- Average target per employee by team
SELECT
    team,
    AVG(annual_target) AS avg_target
FROM clean_employees AS e
INNER JOIN targets AS t
ON e.employee_id = t.employee_id
GROUP BY e.team;

-- Employees with targets over 10,000
SELECT
    e.employee_name,
    t.annual_target
FROM clean_employees AS e
INNER JOIN targets AS t
ON e.employee_id = t.employee_id
WHERE t.annual_target > 10000; -- Filters rows before aggregation

-- Teams whose total target exceeds 10,000
SELECT
    team,
    SUM(annual_target) AS team_target_value
FROM clean_employees AS e
INNER JOIN targets AS t
ON e.employee_id = t.employee_id
GROUP BY e.team
HAVING SUM(annual_target) > 10000; -- Filters groups after aggregation

-- Discover the smallest and largest targets per team 
SELECT
    e.team,
    MIN(annual_target) AS smallest_team_target,
    MAX(annual_target) AS largest_team_target
FROM clean_employees AS e 
INNER JOIN targets AS t 
ON e.employee_id = t.employee_id
GROUP BY team;

-- Using CASE to sort targets into low, med & high bands
SELECT
    e.employee_name,
    t.annual_target,
    CASE
        WHEN t.annual_target >= 15000 THEN 'High'
        WHEN t.annual_target >= 10000 THEN 'Medium'
        ELSE 'Low' -- Anything lower than 10,000 is sorted as 'low'
    END AS target_band
FROM clean_employees AS e
INNER JOIN targets AS t
ON e.employee_id = t.employee_id;

-- Categorise offices using CASE
SELECT 
    team,
    CASE
        WHEN team LIKE '%Manchester%' THEN 'Flagship North'
        WHEN team LIKE '%London%' THEN 'Flagship South'
        ELSE 'Mid-level office'
    END AS office_category
FROM clean_employees
GROUP BY team
ORDER BY office_category;

-- GROUP BY and CASE: counting employees per grouped office category 
SELECT
    CASE
        WHEN team LIKE '%Manchester%' THEN 'Flagship North'
        WHEN team LIKE '%London%' THEN 'Flagship South'
        ELSE 'Mid-level office'
    END AS office_category,
    COUNT(*) AS employee_count
FROM clean_employees
GROUP BY
    CASE
        WHEN team LIKE '%Manchester%' THEN 'Flagship North'
        WHEN team LIKE '%London%' THEN 'Flagship South'
        ELSE 'Mid-level office'
    END;

-- Using a subquery to discover employees achieving above average targets
SELECT
    e.employee_name,
    t.annual_target
FROM clean_employees AS e
INNER JOIN targets AS t
ON e.employee_id = t.employee_id
WHERE t.annual_target > (
    SELECT AVG(annual_target)
    FROM targets
);

-- Using a subquery to discover employees tracking below average
SELECT
    e.employee_name,
    t.annual_target
FROM clean_employees AS e
INNER JOIN targets AS t
ON e.employee_id = t.employee_id
WHERE t.annual_target < (
    SELECT AVG(annual_target)
    FROM targets
);