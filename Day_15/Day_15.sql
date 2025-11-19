
/* ### Daily Challenge:

**Question:** Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted that week, total patients 
refused, average patient satisfaction, count of staff assigned to service, and count of staff present that week. Order by patients admitted descending.
*/

SELECT
 sw.service,
 SUM(sw.patients_admitted) AS total_patients_admitted,
 SUM(sw.patients_refused) AS total_patients_refused,
 ROUND(AVG(sw.patient_satisfaction), 2) AS avg_satisfaction,
 COUNT(DISTINCT s.staff_id) AS total_staff,
 COUNT(CASE WHEN ss.present = 1 THEN 1 END) AS total_staff_present
FROM services_weekly sw
JOIN staff s 
 ON sw.service = s.service
JOIN staff_schedule ss 
 ON s.staff_id = ss.staff_id
WHERE sw.week = 20 
 AND ss.week = 20
GROUP BY sw.service
ORDER BY total_patients_admitted DESC;
