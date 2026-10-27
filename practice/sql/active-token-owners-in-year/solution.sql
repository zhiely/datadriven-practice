SELECT(COUNT(DISTINCT(owner_id)))
FROM api_tokens
WHERE YEAR(issued) = 2026
