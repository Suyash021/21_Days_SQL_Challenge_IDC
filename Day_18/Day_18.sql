/* ### Day 18 (24/11): UNION and UNION ALL

**Topics:** UNION, UNION ALL, combining result sets  */

/* ### Practice Questions:

1. Combine patient names and staff names into a single list.
2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
3. List all unique names from both patients and staff tables. */ 
  

SELECT name AS full_name, 'Patient' AS type, service
FROM patients
UNION ALL SELECT staff_name AS full_name, 'Staff' AS type, service
FROM staff
ORDER BY service, type, full_name;  


SELECT patient_id, name, satisfaction, 'High Performer' AS category 
FROM patients
WHERE satisfaction >= 90 
UNION SELECT patient_id, name, satisfaction, 'Low Performer' AS category 
FROM patients
WHERE satisfaction < 50 
ORDER BY satisfaction DESC;
-- All unique services from multiple tables


SELECT DISTINCT service 
FROM patients
UNION SELECT DISTINCT service 
FROM staff
UNION SELECT DISTINCT service 
FROM services_weekly; 



-- Monthly summary from different metrics
SELECT
    'Admissions' AS metric,
    month,
    SUM(patients_admitted) AS value FROM services_weekly
GROUP BY month UNION ALL SELECT
    'Refusals' AS metric,
    month,
    SUM(patients_refused) AS value FROM services_weekly
GROUP BY month ORDER BY month, metric;





/* ### Daily Challenge:

**Question:** Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), full name, type ('Patient' or 'Staff'),
 and associated service. Include only those in 'surgery' or 'emergency' services. Order by type, then service, then name. */
 
 
SELECT patient_id , name as Full_name, 'Patient' as type ,service as associated_service 
FROM patients 
WHERE service in ('surgery','emergency')
UNION SELECT staff_id ,staff_name as Full_name, 'Staff' as type , service as asssociated_service 
FROM staff 
WHERE service in ('surgery','emergency')
ORDER BY type, associated_service, Full_name;
 
