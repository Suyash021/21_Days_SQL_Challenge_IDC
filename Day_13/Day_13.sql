/* ### Day 13 (17/11): INNER JOIN

**Topics:** INNER JOIN, joining two tables, relationship understanding */

/* ### Practice Questions:

1. Join patients and staff based on their common service field (show patient and staff who work in same service).
2. Join services_weekly with staff to show weekly service data with staff information.
3. Create a report showing patient information along with staff assigned to their service. */ 

SELECT 
	p.name ,
    s.staff_name,
    s.service
FROM patients p 
inner join staff s ON p.service = s.service ;



SELECT 
	s.staff_name,
    s.role,
    sw.week,
    sw.service
FROM services_weekly sw
INNER JOIN staff s 
ON s.service = sw.service  ;

select * FROm patients;

SELECT 
	p.name,
    p.age , 
    p.satisfaction,
    p.service,
    sc.staff_name,
    sc.role,
    sc.present
    
FROM patients p
INNER JOIN staff_schedule sc 
ON p.service = sc.service ;



/* ### Daily Challenge:

**Question:** Create a comprehensive report showing patient_id, patient name, age, service, and the total number of staff members available in their 
service. Only include patients from services that have more than 5 staff members. Order by number of staff descending, then by patient name. */



SELECT 
	p.patient_id,
    p.name as patient_name,
    p.age,
    s.service,    
	COUNT(s.staff_id) AS staff_count
FROM patients p
INNER JOIN staff s 
ON p.service = s.service
GROUP BY 
p.patient_id, p.age,p.name,p.service
HAVING COUNT(s.staff_id) > 5
ORDER BY 
staff_count DESC,
p.name;






