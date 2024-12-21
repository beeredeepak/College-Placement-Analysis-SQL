CREATE TABLE placements (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    cgpa DECIMAL(3,2),
    backlogs INT,
    intern_experience BOOLEAN,
    placed BOOLEAN,
    branch VARCHAR(50),
    semester INT
);

-- Overall Placement Rate:

SELECT COUNT(*) AS total_students,
       COUNT(*) FILTER (WHERE placed = TRUE) AS placed_students,
       (COUNT(*) FILTER (WHERE placed = TRUE) / COUNT(*)) * 100 AS placement_rate
FROM placements;

-- Placement by Branch:

SELECT branch,
       COUNT(*) AS total_students,
       COUNT(*) FILTER (WHERE placed = TRUE) AS placed_students,
       (COUNT(*) FILTER (WHERE placed = TRUE) / COUNT(*)) * 100 AS placement_rate
FROM placements
GROUP BY branch;

-- Impact of CGPA:

SELECT AVG(cgpa) AS avg_cgpa, AVG(placed) AS avg_placed
FROM placements
GROUP BY placed;

-- Impact of Internship Experience:

SELECT intern_experience,
       COUNT(*) AS total_students,
       COUNT(*) FILTER (WHERE placed = TRUE) AS placed_students,
       (COUNT(*) FILTER (WHERE placed = TRUE) / COUNT(*)) * 100 AS placement_rate
FROM placements
GROUP BY intern_experience;

-- Correlation Analysis:

SELECT CORR(cgpa, placed) AS cgpa_placed_correlation;

-- Identifying Top Performers:

SELECT name, cgpa, backlogs, intern_experience, placed
FROM placements
WHERE cgpa >= 9.0 AND backlogs = 0 AND intern_experience = 1
ORDER BY cgpa DESC;

-- Analyzing Placement Trends by Semester:

SELECT semester, COUNT(*) AS total_students, 
       SUM(placed) AS placed_students, 
       (SUM(placed) / COUNT(*)) * 100 AS placement_rate
FROM placements
GROUP BY semester;

-- Identifying Factors Correlated with Placement Success:

SELECT CORR(cgpa, placed) AS cgpa_correlation,
       CORR(backlogs, placed) AS backlogs_correlation,
       CORR(intern_experience, placed) AS intern_experience_correlation
FROM placements;

-- Identifying High-Potential Students:

SELECT name, cgpa, backlogs, intern_experience
FROM placements
WHERE cgpa >= 8.5 AND backlogs <= 1 AND intern_experience = 1;

-- Analyzing Placement Trends by Branch:

SELECT branch, COUNT(*) AS total_students, 
       SUM(placed) AS placed_students, 
       (SUM(placed) / COUNT(*)) * 100 AS placement_rate
FROM placements
GROUP BY branch
ORDER BY placement_rate DESC;

-- Identifying Students with High CGPA but Low Placements:

SELECT name, cgpa, placed
FROM placements
WHERE cgpa >= 8.5 AND placed = 0;

-- Identifying Students with High CGPA but Low Placements:

SELECT name, cgpa, placed
FROM placements
WHERE cgpa >= 8.5 AND placed = 0
ORDER BY cgpa DESC;

-- Analyzing Placement Trends by Branch and Semester:

SELECT branch, semester, COUNT(*) AS total_students, 
       SUM(placed) AS placed_students, 
       (SUM(placed) / COUNT(*)) * 100 AS placement_rate
FROM placements
GROUP BY branch, semester
ORDER BY branch, semester;

--  Identifying Students with Multiple Backlogs and Placements:

SELECT name, backlogs, placed
FROM placements
WHERE backlogs > 1 AND placed = 1;

-- Analyzing the Impact of Internship Experience:

SELECT intern_experience, COUNT(*) AS total_students, 
       SUM(placed) AS placed_students, 
       (SUM(placed) / COUNT(*)) * 100 AS placement_rate
FROM placements
GROUP BY intern_experience;

-- Identifying Outliers in CGPA and Backlogs:

SELECT *
FROM placements
WHERE cgpa > (SELECT AVG(cgpa) + 2 * STDDEV(cgpa) FROM placements)
   OR backlogs > (SELECT AVG(backlogs) + 2 * STDDEV(backlogs) FROM placements);

--  Identifying Top-Performing Students in Each Branch:

SELECT branch, name, cgpa
FROM placements
WHERE cgpa IN (
    SELECT MAX(cgpa)
    FROM placements
    GROUP BY branch
)
ORDER BY branch;

-- Analyzing the Impact of Internship Experience on Placement Success:

SELECT intern_experience, COUNT(*) AS total_students, 
       SUM(placed) AS placed_students, 
       (SUM(placed) / COUNT(*)) * 100 AS placement_rate
FROM placements
GROUP BY intern_experience;

-- Identifying Students with High Backlogs and Placements:

SELECT name, backlogs, placed
FROM placements
WHERE backlogs > 2 AND placed = 1;

-- Analyzing the Relationship Between CGPA and Placements:

SELECT cgpa, COUNT(*) AS total_students, 
       SUM(placed) AS placed_students, 
       (SUM(placed) / COUNT(*)) * 100 AS placement_rate
FROM placements
GROUP BY cgpa;

--  Identifying Students with Low CGPA but High Placements:

SELECT name, cgpa, placed
FROM placements
WHERE cgpa < 7.0 AND placed = 1;

--  Identifying Students with Significant Improvement in CGPA:

SELECT name, cgpa, semester
FROM placements
WHERE cgpa > (
    SELECT AVG(cgpa)
    FROM placements
    WHERE semester = (SELECT MIN(semester) FROM placements)
)
ORDER BY cgpa DESC;

-- Analyzing the Impact of Branch on Placement Success:

SELECT branch, COUNT(*) AS total_students, 
       SUM(placed) AS placed_students, 
       (SUM(placed) / COUNT(*)) * 100 AS placement_rate
FROM placements
GROUP BY branch
ORDER BY placement_rate DESC;

--  Identifying Students with High Backlogs but Successful Placements:

SELECT name, backlogs, placed
FROM placements
WHERE backlogs > 2 AND placed = 1
ORDER BY backlogs DESC;

-- Analyzing Placement Trends Over Time:

SELECT semester, COUNT(*) AS total_students, 
       SUM(placed) AS placed_students, 
       (SUM(placed) / COUNT(*)) * 100 AS placement_rate
FROM placements
GROUP BY semester
ORDER BY semester;

--  Identifying Students with Low CGPA but High Placements in Specific Branches:

SELECT name, cgpa, placed, branch
FROM placements
WHERE cgpa < 7.0 AND placed = 1
  AND branch IN ('CSE', 'IT')  -- Adjust branches as needed
ORDER BY cgpa ASC;

