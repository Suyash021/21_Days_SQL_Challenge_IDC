--  LIMIT is applied last: FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT 

/* Tips & Tricks
✅ Pagination formula: OFFSET = (page_number - 1) × page_size
✅ Combine with ORDER BY for consistent results:
-- ❌ Unpredictable: LIMIT without ORDER BY-- ✅ Predictable: Always use ORDER BY with LIMITSELECT * FROM patients
ORDER BY patient_id
LIMIT 10 OFFSET 20; */



/* ### Practice Questions:

1. Display the first 5 patients from the patients table.
2. Show patients 11-20 using OFFSET.
3. Get the 10 most recent patient admissions based on arrival_date. */ 

SELECT * FROM patients LIMIT 5;

SELECT * FROM patients LIMIT 10 offset 10;

SELECT * FROM patients 
ORDER BY arrival_date DESC 
LIMIT 10;



/* ### Daily Challenge:

**Question:** Find the 3rd to 7th highest patient satisfaction scores from the patients table, showing patient_id, name, service, and satisfaction. 
Display only these 5 records. */ 


SELECT patient_id , name , service , satisfaction 
FROM patients
ORDER BY satisfaction DESC 
LIMIT 5 
OFFSET 2;



