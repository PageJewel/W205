SELECT
  corr(h.overall_standardized_score,s.overall_rating) AS corr_hosp_survey_ratings,
  corr(h.sd_standardized_score,s.overall_rating) AS corr_hosp_variability_survey_rating
FROM (SELECT
	  provider_id,
	  AVG(sd_better_than_mean) AS overall_standardized_score,
	  STDDEV_POP(sd_better_than_mean) AS sd_standardized_score
	FROM hospital_procedure_scores
	GROUP BY
	  provider_id
	HAVING count(*)>5) h
INNER JOIN survey_results s
	ON h.provider_id = s.provider_id;