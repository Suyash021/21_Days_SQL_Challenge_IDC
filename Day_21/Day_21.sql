/*### Day 21 (27/11): Common Table Expressions (CTEs)
**Topics:** WITH clause, CTEs, recursive CTEs (if applicable), query organization 

### Practice Questions:

1. Create a CTE to calculate service statistics, then query from it.
2. Use multiple CTEs to break down a complex query into logical steps.
3. Build a CTE for staff utilization and join it with patient data.  */ 



WITH service_stats AS (
    SELECT
        service,
        COUNT(*) AS patient_count,
        AVG(satisfaction) AS avg_satisfaction
    FROM patients
    GROUP BY service
)
SELECT *FROM service_stats
WHERE avg_satisfaction > 75 
ORDER BY patient_count DESC; 


WITH
patient_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_patients,
        AVG(age) AS avg_age,
        AVG(satisfaction) AS avg_satisfaction
    FROM patients
    GROUP BY service
),
staff_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_staff
    FROM staff
    GROUP BY service
),
weekly_metrics AS (
    SELECT
        service,
        SUM(patients_admitted) AS total_admitted,
        SUM(patients_refused) AS total_refused
    FROM services_weekly
    GROUP BY service
)
SELECT
    pm.service,
    pm.total_patients,
    pm.avg_age,
    pm.avg_satisfaction,
    sm.total_staff,
    wm.total_admitted,
    wm.total_refused,
    ROUND(100.0 * wm.total_admitted /
          (wm.total_admitted + wm.total_refused), 2) AS admission_rate
FROM patient_metrics pm
LEFT JOIN staff_metrics sm ON pm.service = sm.service
LEFT JOIN weekly_metrics wm ON pm.service = wm.service
ORDER BY pm.avg_satisfaction DESC; 


WITH service_avg AS (
    SELECT service, AVG(satisfaction) AS avg_sat
    FROM patients
    GROUP BY service
)
SELECT *FROM patients p
JOIN service_avg sa ON p.service = sa.service
WHERE p.satisfaction > sa.avg_sat;   


/* ### Daily Challenge:

**Question:** Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level metrics (total admissions, refusals, 
avg satisfaction), 2) Staff metrics per service (total staff, avg weeks present), 3) Patient demographics per service (avg age, count). 
Then combine all three CTEs to create a final report showing service name, all calculated metrics, and an overall performance score 
(weighted average of admission rate and satisfaction). Order by performance score descending.  */ 

-- Hospital Performance Dashboard

WITH service_metrics AS (
    -- 1) Service-level metrics
    SELECT
        service,
        SUM(patients_admitted) AS total_admissions,
        SUM(patients_refused) AS total_refusals,
        ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction
    FROM services_weekly
    GROUP BY service
),

staff_metrics AS (
    -- 2) Staff metrics per service
    SELECT
        s.service,
        COUNT(DISTINCT s.staff_id) AS total_staff,
        ROUND(AVG(ss.present), 2) AS avg_weeks_present
    FROM staff s
    LEFT JOIN staff_schedule ss
        ON s.staff_id = ss.staff_id
    GROUP BY s.service
),

patient_metrics AS (
    -- 3) Patient demographics per service
    SELECT
        service,
        COUNT(*) AS patient_count,
        ROUND(AVG(age), 2) AS avg_age
    FROM patients
    GROUP BY service
),

final_report AS (
    -- 4) Combine everything and calculate performance score
    SELECT
        sm.service,
        sm.total_admissions,
        sm.total_refusals,
        sm.avg_satisfaction,
        stm.total_staff,
        stm.avg_weeks_present,
        pm.patient_count,
        pm.avg_age,

        -- Performance Score:
        -- Mix satisfaction and size of service
        ROUND(
            (
                (sm.total_admissions / 
                    NULLIF((SELECT MAX(total_admissions) FROM service_metrics), 0)
                ) * 50
                +
                (sm.avg_satisfaction * 0.5)
            ), 2
        ) AS performance_score
    FROM service_metrics sm
    LEFT JOIN staff_metrics stm ON sm.service = stm.service
    LEFT JOIN patient_metrics pm ON sm.service = pm.service
)

SELECT *
FROM final_report
ORDER BY performance_score DESC;




