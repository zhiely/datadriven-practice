WITH daily_counts AS(
 SELECT
    DATE(first_at) as error_date, 
    COUNT(first_at)AS error_count
FROM err_tracks
GROUP BY 1

)
SELECT 
    error_date, 
    error_count,
    LAG(error_count)OVER (ORDER BY DATE(error_date) ASC) as prev_count,
    error_count - LAG(error_count)OVER (ORDER BY DATE(error_date) ASC) as day_over_day_change
FROM daily_counts
order by error_date asc
