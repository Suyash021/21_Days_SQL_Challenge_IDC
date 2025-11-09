use hospital;

-- Day 6 (09/11): GROUP BY Clause 


/* ### Practice Questions:

1. Count the number of patients by each service.
2. Calculate the average age of patients grouped by service.
3. Find the total number of staff members per role. */ 


SELECT service, COUNT(*) as no_of_patients 
FROM patients
GROUP BY service; 


SELECT 
	service , AVG(age) as average_age
FROM patients
GROUP BY service;


SELECT role , COUNT(*) as Total_staff
FROM staff
GROUP BY role;

/* ### Daily Challenge:

**Question:** For each hospital service, calculate the total number of patients admitted, total patients refused, and the admission rate
(percentage of requests that were admitted). Order by admission rate descending. */


SELECT service , 
	   SUM(patients_admitted) as Total_Patients_Admitted ,
	   SUM(patients_refused) as Total_Patients_Refused,
       (SUM(patients_admitted) / SUM(patients_request) ) *100  as Admission_Rate
       
FROM services_weekly
GROUP BY service
ORDER BY Admission_Rate DESC;




    