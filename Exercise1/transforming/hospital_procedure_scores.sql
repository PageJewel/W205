-- Create final cleaned table scores by hospital and procedure
-- Include a calculation of SD better than the mean for the procedure
DROP TABLE hospital_procedure_scores;
CREATE TABLE hospital_procedure_scores AS
SELECT
  temp.provider_id,
  temp.measure_id,
  temp.score,
  ((temp.score - proc.avg_score) / proc.sd_score) * proc.direction_better_score as sd_better_than_mean
FROM temp_hospital_procedure_scores temp
LEFT JOIN procedures proc
	ON temp.measure_id = proc.measure_id;

-- Drop the intermediate table that is no longer needed
DROP TABLE temp_hospital_procedure_scores;