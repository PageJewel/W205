-- First, get a list of unique procedures impacting measures of quality of care
-- This also includes a specified list of procedures where a lower score is better (-1) vs higher score is better (1)
DROP TABLE temp_procedures;
CREATE TABLE temp_procedures AS
SELECT DISTINCT
  rd.measure_id,
  rd.measure_name,
  null AS condition,
  -1 AS direction_better_score
FROM readmit_deaths_hospital rd
UNION
SELECT DISTINCT
  ec.measure_id,
  ec.measure_name,
  ec.condition,
  CASE WHEN ec.measure_id IN ("OP_20", "OP_3b", "OP_5", "PC_01", "VTE_6") THEN -1 ELSE 1 END AS direction_better_score
FROM effective_care_hospital ec;

-- Next, join to cleaned table of hospital scores to get overall metrics by procedure
-- Note that this will reduce list of procedures to only those that will be included in final quality calculations due to the inner join
DROP TABLE procedures;
CREATE TABLE procedures AS
SELECT
  proc.measure_id,
  proc.measure_name,
  proc.condition,
  MIN(score.score) AS min_score,
  MAX(score.score) AS max_score,
  AVERAGE(score.score) AS avg_score,
  STDDEV_POP(score.score) AS sd_score,
  proc.direction_better_score
FROM temp_procedures proc
INNER JOIN temp_hospital_procedure_scores score
	ON proc.measure_id = score.measure_id
GROUP BY proc.measure_id,
  proc.measure_name,
  proc.condition,
  proc.direction_better_score;

-- Drop the initial temp table that is no longer needed
DROP TABLE temp_procedures;