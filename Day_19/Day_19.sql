/* ### Day 19 (25/11): Window Functions - ROW_NUMBER, RANK, DENSE_RANK

**Topics:** ROW_NUMBER(), RANK(), DENSE_RANK(), OVER clause. 
Ranking Functions:
- ROW_NUMBER(): Sequential numbering (1, 2, 3, 4…)
- RANK(): Same values get same rank, gaps after ties (1, 2, 2, 4…)
- DENSE_RANK(): Same values get same rank, no gaps (1, 2, 2, 3…)  */


/* ### Practice Questions:

1. Rank patients by satisfaction score within each service.
2. Assign row numbers to staff ordered by their name.
3. Rank services by total patients admitted. */ 


SELECT
    patient_id,
    name,
    service,
    satisfaction,
    ROW_NUMBER() OVER (PARTITION BY service ORDER BY satisfaction DESC) AS row_num
FROM patients;


-- Rank patients by satisfaction (with ties)
SELECT
    patient_id,
    name,
    satisfaction,
    RANK() OVER (ORDER BY satisfaction DESC) AS rnk,
    DENSE_RANK() OVER (ORDER BY satisfaction DESC) AS dense_rnk
FROM patients; 

-- Top 3 weeks by satisfaction per service
SELECT * 
FROM (
    SELECT
        service,
        week,
        patient_satisfaction,
        RANK() OVER (PARTITION BY service ORDER BY patient_satisfaction DESC) AS sat_rank
    FROM services_weekly
) as top_week


SELECT
    service,
    SUM(patients_admitted) AS total_admitted,
    RANK() OVER (ORDER BY SUM(patients_admitted) DESC) AS admission_rank
FROM services_weekly
GROUP BY service;



/* ### Daily Challenge:

**Question:** For each service, rank the weeks by patient satisfaction score (highest first). Show service, week, patient_satisfaction,
 patients_admitted, and the rank. Include only the top 3 weeks per service. */ 




SELECT 
    service,
    week,
    patient_satisfaction,
    patients_admitted,
    sat_rank
FROM (
    SELECT 
        service,
        week,
        patient_satisfaction,
        patients_admitted,
        RANK() OVER (PARTITION BY service ORDER BY patient_satisfaction DESC) AS sat_rank
    FROM services_weekly
) AS ranked_services
WHERE sat_rank <= 3;






