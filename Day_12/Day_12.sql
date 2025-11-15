-- ### Day 12 (15/11): NULL Values and IS NULL/IS NOT NULL

-- **Topics:** NULL handling, IS NULL, IS NOT NULL, COALESCE


## Practice Questions:
/*
1. Find all weeks in services_weekly where no special event occurred.
2. Count how many records have null or empty event values.
3. List all services that had at least one week with a special event.*/


SELECT 
    distinct week,
    event
FROM services_weekly
WHERE event ='none';


SELECT DISTINCT service
FROM services_weekly
WHERE event NOT IN ('none', 'No Event') AND event IS NOT NULL;


SELECT 
	COUNT(*)
FROM services_weekly
WHERE event ='none' or event IS NULL;


/* ## Daily Challenge:

**Question:** Analyze the event impact by comparing weeks with events vs weeks without events. Show: event status ('With Event' or 'No Event'),
 count of weeks, average patient satisfaction, and average staff morale. Order by average patient satisfaction descending.*/
 
SELECT 
  CASE 
    WHEN event IS NULL OR event = 'none' THEN 'No Event'
    ELSE 'With Event'
  END AS event_status,
  COUNT(*) AS week_count,
  AVG(patient_satisfaction) AS avg_patient_satisfaction,
  AVG(staff_morale) AS avg_staff_morale
FROM
  services_weekly
GROUP BY 
  CASE 
    WHEN event IS NULL OR event = 'none' THEN 'No Event'
    ELSE 'With Event'
  END
ORDER BY avg_patient_satisfaction DESC;

 
 
 
 
 
 




