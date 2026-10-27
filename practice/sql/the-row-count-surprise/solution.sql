WITH inner_count AS(
  SELECT 'inner_join' as join_type, COUNT(*) as row_count
  FROM users u
  INNER JOIN ad_impressions a
  ON u.user_id = a.user_id
),
left_count AS(
 SELECT 'left_join' as join_type, COUNT(*) as row_count
  FROM users u
  LEFT JOIN ad_impressions a
  ON u.user_id = a.user_id
),
full_outer_count AS(
 SELECT 'full_outer_join' as join_type, COUNT(*) as row_count
  FROM users u
  FULL JOIN ad_impressions a
  ON u.user_id = a.user_id
)
select * from inner_count
UNION ALL
select * from left_count
UNION ALL
select * from full_outer_count;
