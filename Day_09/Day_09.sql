/*  ### Day 9 (12/11): Date Functions

**Topics:** DATE functions, date arithmetic, EXTRACT  */ 



/* ### Practice Questions:

1. Extract the year from all patient arrival dates.
2. Calculate the length of stay for each patient (departure_date - arrival_date).
3. Find all patients who arrived in a specific month. */ 

SELECT 
	name, 
    EXTRACT(YEAR FROM arrival_date) as Year
FROM patients;


SELECT 
 name,
  DATEDIFF(departure_date, arrival_date) AS length_of_stay
FROM patients;


SELECT * 
FROM patients
WHERE MONTH(arrival_date) = 04;



/* ### Daily Challenge:

**Question:** Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. 
Also show the count of patients and order by average stay descending.*/


SELECT
	service,
	 ROUND(AVG(DATEDIFF(departure_date, arrival_date)),2) AS avg_length_of_stay ,
     COUNT(patient_id) as Patient_Count
FROM patients
GROUP BY service 
HAVING avg_length_of_stay >= 7
ORDER BY avg_length_of_stay DESC;


SELECT distinct(service) FROM PATIENTS;


