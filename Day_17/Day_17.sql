/* ### Day 17 (22/11): Subqueries (SELECT and FROM clause)

**Topics:** Subqueries in SELECT, derived tables, inline views  */ 


/* ### Practice Questions:

1. Show each patient with their service's average satisfaction as an additional column.
2. Create a derived table of service statistics and query from it.
3. Display staff with their service's total patient count as a calculated field. */ 




SELECT p.patient_id, p.name AS patient_name, 
p.service, p.satisfaction AS patient_satisfaction,
(SELECT ROUND(AVG(sw.patient_satisfaction),2)
FROM services_weekly sw
WHERE p.service = sw.service GROUP BY service) AS avg_satisfaction
FROM patients p;



SELECT 
    sw.week, 
    sw.month, 
    sw.patients_admitted, 
    ss.staff_assigned, 
    ss.staff_present, 
    sw.staff_morale, 
    sw.service
FROM 
    services_weekly sw
INNER JOIN (
    SELECT 
        week, 
        service, 
        COUNT(staff_id) AS staff_assigned, 
        SUM(CASE WHEN present = 1 THEN 1 ELSE 0 END) AS staff_present
    FROM 
        staff_schedule
    GROUP BY 
        week, service
) ss 
ON 
    ss.week = sw.week 
    AND ss.service = sw.service;



SELECT 
	ss.week,
    ss.staff_name,
    ss.role, 
    ss.service, 
    (
        SELECT COUNT(p.patient_id)
        FROM patients p
        WHERE WEEK(p.arrival_date) = ss.week
    ) AS patients_count
FROM staff_schedule ss
ORDER BY ss.week;




/* ### Daily Challenge:

**Question:** Create a report showing each service with: service name, total patients admitted, the difference between their total admissions and 
the average admissions across all services, and a rank indicator ('Above Average', 'Average', 'Below Average'). Order by total patients admitted 
descending. */ 
-- SELECT 
-- 	s1.service,
-- 	SUM(s1.patients_admitted) as total_admitted,
--     SUM(s1.patients_admitted) - (SELECT Round(AVG(s2.patients_admitted),2) FROM services_weekly s2 WHERE s1.service = s2.service GROUP BY s2.service) as Diff_AVG_Total,
--     (SELECT Round(AVG(s2.patients_admitted),2) FROM services_weekly s2 WHERE s1.service = s2.service GROUP BY s2.service) as avg_patients_per_service
--     
-- FROM services_weekly s1
-- GROUP BY s1.service;



SELECT svc.service AS service_name,
svc.total_patients AS total_patients_admitted,
ROUND(svc.total_patients - avg_table.avg_patients, 2) 
AS difference_between_total_and_avg,
CASE
WHEN svc.total_patients > avg_table.avg_patients THEN 'Above Average'
WHEN svc.total_patients = avg_table.avg_patients THEN 'Average'
ELSE 'Below Average'
END AS rank_indicator
FROM(
SELECT service, SUM(patients_admitted) AS total_patients
FROM services_weekly
GROUP BY service
) AS svc,
( SELECT AVG(total_patients) AS avg_patients
FROM (
SELECT SUM(patients_admitted) AS total_patients
FROM services_weekly
GROUP BY service
) AS inner_avg
) AS avg_table
ORDER BY svc.total_patients DESC;