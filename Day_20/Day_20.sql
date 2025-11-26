/* ### Day 20 (26/11) : Window Functions - Aggregate Window Functions

**Topics:** SUM() OVER, AVG() OVER, running totals, moving averages. */ 



/* ### Practice Questions:

1. Calculate running total of patients admitted by week for each service.
2. Find the moving average of patient satisfaction over 4-week periods.
3. Show cumulative patient refusals by week across all services.  */ 



SELECT
    service,
    week,
    patients_admitted,
    SUM(patients_admitted) OVER (
        PARTITION BY service
        ORDER BY week
    ) AS cumulative_admissions
FROM services_weekly
ORDER BY service, week;


SELECT
    service,
    week,
    patient_satisfaction,
    ROUND(AVG(patient_satisfaction) OVER (
        PARTITION BY service
        ORDER BY week
        ROWS BETWEEN 3 PRECEDING AND CURRENT ROW    ), 2) AS moving_avg_4week
FROM services_weekly
ORDER BY service, week;

SELECT * FROM services_weekly;

SELECT
    week,
    SUM(patients_refused) AS weekly_refusals,
    SUM(SUM(patients_refused)) OVER (ORDER BY week) AS cumulative_refusals
FROM services_weekly
GROUP BY week
ORDER BY week; 



/* ### Daily Challenge:

**Question:** Create a trend analysis showing for each service and week: week number, patients_admitted, running total of patients admitted (cumulative),
 3-week moving average of patient satisfaction (current week and 2 prior weeks), and the difference between current week admissions and the service
 average. Filter for weeks 10-20 only. */ 
 
select
    service,
    week,
    patients_admitted,
    
    -- running total (cumulative admissions)
    sum(patients_admitted) over (
        partition by service
        order by week
    ) as cumulative_admissions,
    
    -- 3-week moving average (current + 2 previous)
    round(
        avg(patient_satisfaction) over (
            partition by service
            order by week
            rows between 2 preceding and current row
        ), 2
    ) as moving_avg_3week,
    
    -- difference between this week's admissions and service average
    patients_admitted
        - avg(patients_admitted) over (partition by service)
      as diff_from_service_avg

from services_weekly
where week between 10 and 20
order by service, week;
 
 
 