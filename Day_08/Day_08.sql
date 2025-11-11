/* ### Day 8 (11/11): String Functions

**Topics:** UPPER, LOWER, LENGTH, CONCAT, SUBSTRING */ 



/* ### Practice Questions:

1. Convert all patient names to uppercase.
2. Find the length of each staff member's name.
3. Concatenate staff_id and staff_name with a hyphen separator. */

SELECT patient_id,UPPER(name) as name, age, arrival_date, departure_date,service,satisfaction
FROM patients;


SELECT staff_name, LENGTH(staff_name) as Name_length 
FROM staff;

SELECT CONCAT(staff_id, ' - ' ,staff_name) as Staff_Info
FROM staff;




/* ### Daily Challenge:

**Question:** Create a patient summary that shows patient_id, full name in uppercase, service in lowercase, age category 
(if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length. Only show patients whose name length is greater
than 10 characters. */ 


SELECT 
	patient_id,
    UPPER(name) as Patient_name,
    LOWER(service) as service,
    CASE 
		WHEN age >=65 THEN 'Senior'
        WHEN age >=18 THEN 'Adult' 
        ELSE 'Minor' 
	END AS age_category, 
    LENGTH(name) as name_length 
FROM patients
WHERE LENGTH(name) >10;



