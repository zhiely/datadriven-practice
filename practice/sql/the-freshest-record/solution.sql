-- -- --1) identify new incidents
-- -- SELECT 
-- --   server_name, 
-- --   message,
-- --   MIN(log_timestamp) AS new_incidents
-- -- FROM server_logs
-- -- GROUP BY server_name,message
-- -- --Found the absolute first appearance of each unique issue.

-- -- --2) within last 90 days
-- -- SELECT 
-- --   server_name, 
-- --   message,
-- --   MIN(log_timestamp) AS new_incidents
-- -- FROM server_logs
-- -- GROUP BY server_name,message
-- -- HAVING MIN(log_timestamp) >= CURRENT_DATE - INTERVAL '90 DAYS'
-- -- --Filtered out long-running issues by checking if their first appearance was within 90 days.

-- --3) order by desc (most recently)
-- WITH first_sightings AS(
--   SELECT 
--     server_name, 
--     message,
--     MIN(log_timestamp) AS new_incidents
--   FROM server_logs
--   GROUP BY server_name,message
--   HAVING MIN(log_timestamp) >= CURRENT_DATE - INTERVAL '90 DAYS'
--  )
-- select l.*
-- from server_logs l
-- JOIN first_sightings f
--   ON l.server_name = f.server_name
--   AND l.message = f.message
--   AND l.log_timestamp = f.new_incidents
-- ORDER BY l.log_timestamp DESC;

--updated:
--1)find each pair's earliest row across ALL history first, 

--TIP:By using ASC, we force row #1 to be the true origin date of the issue, allowing us to accurately check if that origin date lands within our 90-day window.
WITH first_sightings AS(
  SELECT *,
  row_number() over (partition by server_name,message order by log_timestamp ASC) as occurence_rank
  FROM server_logs
)
  
SELECT *
from first_sightings
where occurence_rank = 1
AND log_timestamp >= CURRENT_DATE - INTERVAL '90 days'
ORDER BY log_timestamp DESC;
