-- Employees table queries

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

-- Finding the earliest and latest start dates
SELECT
    MIN(start_date) AS earliest_start_date,
    MAX(start_date) AS latest_start_date
FROM clean_employees;

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

-- Employees with targets over a threshold
SELECT
    e.employee_name,
    t.annual_target
FROM clean_employees AS e
INNER JOIN targets AS t
ON e.employee_id = t.employee_id
WHERE t.annual_target > 10000; -- Filters rows before aggregation

-- Teams whose total target exceeds a value
SELECT
    team,
    SUM(annual_target) AS team_target_value
FROM clean_employees AS e
INNER JOIN targets AS t
ON e.employee_id = t.employee_id
GROUP BY e.team
HAVING SUM(annual_target) > 10000; -- Filters groups after aggregation