-- Day 5 (07/11): Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)

/* ### Practice Questions:

1. Count the total number of patients in the hospital.
2. Calculate the average satisfaction score of all patients.
3. Find the minimum and maximum age of patients.*/

SELECT COUNT(patient_id) as no_of_patients FROM  patients;

SELECT ROUND(AVG(satisfaction),2) as avg_satisfaction_score
FROM patients;

SELECT MIN(age) as min_age , MAX(age) as max_age 
FROM patients; 


SELECT * 
FROM patients
WHERE patients.age =0;


/* ### Daily Challenge:

**Question:** Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and
weeks. Round the average satisfaction to 2 decimal places. */

SELECT DISTINCT(service) FROM services_weekly;


SELECT SUM(patients_admitted) as Total_Admission, SUM(patients_refused) as Total_Refusal , ROUND(AVG(patient_satisfaction),2) as Average_satisfaction
FROM services_weekly;


