SELECT
  h.state,
  AVG(scores.sd_better_than_mean) AS overall_standardized_score,
  STDDEV_POP(scores.sd_better_than_mean) AS sd_standardized_score,
  AVG(scores.sd_better_than_mean) - STDDEV_POP(scores.sd_better_than_mean) AS sd_below_overall_standardized_score
FROM hospital_procedure_scores scores
LEFT JOIN hospitals h
	ON scores.provider_id = h.provider_id
GROUP BY
  h.state
HAVING count(*)>25
ORDER BY
  sd_below_overall_standardized_score desc
LIMIT 10;