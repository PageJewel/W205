SELECT
  measure_id,
  measure_name,
  sd_score
FROM procedures
GROUP BY
  measure_id,
  measure_name
ORDER BY
  sd_score desc
LIMIT 10;