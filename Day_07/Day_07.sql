-- ### Day 7 (10/11): HAVING Clause

-- **Topics:** HAVING clause, filtering aggregated results

/* ### Practice Questions:

1. Find services that have admitted more than 500 patients in total.
2. Show services where average patient satisfaction is below 75.
3. List weeks where total staff presence across all services was less than 50. */ 

SELECT * FROM staff_schedule;

SELECT service ,SUM(patients_admitted) as total_patients
FROM services_Weekly
GROUP BY service 
HAVING total_patients>500;


SELECT service , AVG(patient_satisfaction) as Average_Satisfaction
FROM services_weekly
GROUP BY service 
HAVING Average_Satisfaction <75; 







SELECT week , SUM(present) as Total_Staff_Present
FROM staff_schedule
GROUP BY week
HAVING Total_Staff_Present <50;



/* ### Daily Challenge:

**Question:** Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80. 
Show service name, total refused, and average satisfaction. */ 



SELECT service , SUM(patients_refused) as total_refused , AVG(patient_satisfaction) as Patient_Satisfaction 
FROM services_weekly
GROUP BY service
HAVING total_refused >= 100 and Patient_Satisfaction <=80 ;






