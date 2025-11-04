-- Day 2 (04/11): Filtering Data with WHERE Clause

use hospital;

/* ### Practice Questions:

1. Find all patients who are older than 60 years.
2. Retrieve all staff members who work in the 'Emergency' service.
3. List all weeks where more than 100 patients requested admission in any service. */


SELECT * FROM patients WHERE patients.age >60;

SELECT * FROM staff WHERE service='emergency';

SELECT * FROM services_weekly WHERE services_weekly.patients_request > 100;


-- Question: Find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score.

SELECT * FROM patients WHERE patients.service = 'surgery' and satisfaction < 70;



