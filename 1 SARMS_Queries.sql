-- MIU-SEN 303 - Assignment 1
-- Student Academic Records Management System (SARMS)
-- Core SQL queries from the assignment
-- Run the Assignment 1 DDL and population scripts first.

USE University_SARMS_DB;

-- 1. Retrieve all registered students and their departments.
SELECT
    s.stud_id,
    CONCAT(s.fname, ' ', s.lname) AS full_name,
    s.mail,
    d.dept_title
FROM Student AS s
LEFT JOIN Department AS d ON s.dept_id = d.dept_id;

-- 2. Display students enrolled in a specific course (example: CSC101).
SELECT
    s.stud_id,
    CONCAT(s.fname, ' ', s.lname) AS full_name,
    c.crs_code,
    c.crs_title
FROM Enrollment AS e
JOIN Student AS s ON e.stud_id = s.stud_id
JOIN Course AS c ON e.crs_id = c.crs_id
WHERE c.crs_code = 'CSC101';

-- 3. Retrieve one student's academic results for a given session.
-- Change stud_id and session_id as required.
SELECT
    c.crs_code,
    c.crs_title,
    c.units,
    r.ca_mark,
    r.exam_mark,
    r.total_mark,
    r.letter_grade,
    r.gp
FROM Result AS r
JOIN Enrollment AS e ON r.enroll_id = e.enroll_id
JOIN Course AS c ON e.crs_id = c.crs_id
WHERE e.stud_id = 1
  AND e.session_id = 1;

-- 4. Calculate each student's semester GPA for a given session.
SELECT
    e.stud_id,
    SUM(r.gp * c.units) / NULLIF(SUM(c.units), 0) AS semester_gpa
FROM Result AS r
JOIN Enrollment AS e ON r.enroll_id = e.enroll_id
JOIN Course AS c ON e.crs_id = c.crs_id
WHERE e.session_id = 1
GROUP BY e.stud_id;

-- 5. Identify students who have not registered for any courses.
SELECT
    s.stud_id,
    CONCAT(s.fname, ' ', s.lname) AS full_name
FROM Student AS s
LEFT JOIN Enrollment AS e ON s.stud_id = e.stud_id
WHERE e.enroll_id IS NULL;

-- 6. Generate course enrollment summary reports.
SELECT
    c.crs_code,
    c.crs_title,
    COUNT(e.stud_id) AS total_enrolled
FROM Course AS c
LEFT JOIN Enrollment AS e ON c.crs_id = e.crs_id
GROUP BY c.crs_id, c.crs_code, c.crs_title;

-- 7. Update a student's email contact details.
-- This sample updates student 1. Use an email address that is not already in use.
UPDATE Student
SET mail = 'abdulrahman.muhammad.aliyu@university.edu'
WHERE stud_id = 1;

-- 8. Delete an enrollment record safely.
-- This sample targets student 5/course 3/session 1; no matching sample row
-- is inserted by the population script, so change the IDs to a real enrollment
-- if you want to observe a deletion.
DELETE FROM Enrollment
WHERE stud_id = 5
  AND crs_id = 3
  AND session_id = 1;

-- End of SARMS queries.
