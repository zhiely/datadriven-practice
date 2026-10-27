WITH ranked_costs AS(
    SELECT
      amount,
      DENSE_RANK() OVER (ORDER BY amount DESC) AS cost_rank
    FROM cloud_costs 
)
SELECT DISTINCT amount
FROM ranked_costs
WHERE cost_rank <=3
ORDER BY amount DESC;
