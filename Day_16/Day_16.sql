/* ### Day 16 (21/11): Subqueries (WHERE clause)

**Topics:** Subqueries in WHERE, nested queries, filtering with subqueries */ 

### Daily Challenge:

 /* **Question:** Find all patients who were admitted to services that had at least one week where patients were refused AND the average patient 
 satisfaction for that service was below the overall hospital average satisfaction.Show patient_id, name, service, and their personal satisfaction score. */



SELECT p.patient_id, p.name AS patient_name, p.service, p.satisfaction FROM patients p
WHERE p.service IN (
    SELECT service
    FROM services_weekly
    WHERE patients_refused > 0
)
AND p.service IN (
    SELECT service FROM services_weekly GROUP BY service
    HAVING AVG(patient_satisfaction) <
           (SELECT AVG(patient_satisfaction) FROM services_weekly)
);



