/* ### Day 10 (13/11): CASE Statements

**Topics:** CASE WHEN, conditional logic, derived columns. */ 

/* ### Practice Questions:

1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
2. Label staff roles as 'Medical' or 'Support' based on role type.
3. Create age groups for patients (0-18, 19-40, 41-65, 65+).*/ 

SELECT 
	patient_id,
	name,
    satisfaction,
	CASE 	WHEN satisfaction > 80 THEN 'High' 	WHEN satisfaction = 80 THEN 'Medium' 	WHEN satisfaction < 80 THEN 'Low' 
		END AS Satisfaction_Category
FROM patients;





select  
	staff_name,
    role,
    CASE
			WHEN role = 'doctor'  THEN 'Medical' 
            WHEN role = 'nurse'  THEN 'Medical' 
	ELSE 'Support'
	END AS staff_role     
FROM staff;




SELECT 
	patient_id,
	name,
    age,
    CASE 
		WHEN age <= 18 THEN 'Pediatric'
        WHEN age BETWEEN 18 and 40 THEN 'Adult' 
        WHEN age BETWEEN 41 and 65 THEN 'Elder'
        ELSE 'Senior'
	END AS AGE_GROUP
FROM patients;




/* ### Daily Challenge:

**Question:** Create a service performance report showing service name, total patients admitted, and a performance category based on the following: 
'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.*/ 



SELECT 
	service,
    SUM(patients_admitted) as Total_patients_admitted,
    CASE
		WHEN ROUND(AVG(patient_satisfaction),0) >= 85 THEN 'Excellent'
        WHEN ROUND(AVG(patient_satisfaction),0) BETWEEN 75 and 85 THEN 'Good'
        WHEN ROUND(AVG(patient_satisfaction),0) BETWEEN 65 and 75 THEN 'Fair'
        ELSE 'Needs Improvement' 
	END AS performance_category,
   AVG(patient_satisfaction) as Avg_Satisfaction
FROM services_weekly
GROUP BY service
ORDER BY AVG(patient_satisfaction) DESC;



