/* Day 11 (14/11): DISTINCT and Handling Duplicates 
Topics: DISTINCT, removing duplicates, unique values  */ 

/* ### Practice Questions:

1. List all unique services in the patients table.
2. Find all unique staff roles in the hospital.
3. Get distinct months from the services_weekly table.
*/ 

SELECT DISTINCT service 
FROM patients;


SELECT DISTINCT role 
FROM staff;


SELECT DISTINCT month
FROM services_weekly;  


/* ### Daily Challenge:

**Question:** Find all unique combinations of service and event type from the services_weekly table where events are not null or none, 
along with the count of occurrences for each combination. Order by count descending.*/ 


SELECT 
  service,
  event,
  COUNT(*) AS occurrence_count
FROM services_weekly
WHERE event IS NOT NULL AND event != 'none'
GROUP BY service, event
ORDER BY occurrence_count DESC;





