/* ### Day 14 (18/11): LEFT JOIN and RIGHT JOIN

**Topics:** LEFT JOIN, RIGHT JOIN, including unmatched records */ 

/* ### Daily Challenge:

**Question:** Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) and the count of weeks they were present
 (from staff_schedule). Include staff members even if they have no schedule records. Order by weeks present descending. */ 
 
 
 
 SELECT
 st.staff_id,
 st.staff_name,
 st.role,
 st.service,
 SUM(COALESCE(st_sch.present, 0)) AS weeks_present
FROM 
 staff as st
LEFT JOIN 
 staff_schedule as st_sch
ON 
 st.staff_id = st_sch.staff_id
GROUP BY 
 st.staff_id, st.staff_name, st.role, st.service
ORDER BY 
 weeks_present DESC;