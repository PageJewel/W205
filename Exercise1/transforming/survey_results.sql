DROP TABLE survey_results;
CREATE TABLE survey_results AS
SELECT
  s.provider_number AS provider_id,
  s.hcahps_base_score AS overall_rating
FROM survey_responses s
INNER JOIN hospitals h
	ON h.provider_id = s.provider_number
WHERE hcahps_base_score NOT LIKE "%Not Available%";