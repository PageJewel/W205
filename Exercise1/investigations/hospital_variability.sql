SELECT
  measure_id,
  measure_name,
  sd_score
FROM procedures
ORDER BY
  sd_score desc
LIMIT 10;