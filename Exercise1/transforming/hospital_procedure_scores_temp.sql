-- Create initial cleaned table of hospitals and scores
-- Cleaning removes measures, hospitals, and scores that will not be included in final calculations
DROP TABLE temp_hospital_procedure_scores;
CREATE TABLE temp_hospital_procedure_scores AS
SELECT
  rd.provider_id,
  rd.measure_id,
  cast(rd.score as smallint) as score
FROM readmit_deaths_hospital rd
INNER JOIN hospitals h
	on rd.provider_id = h.provider_id
WHERE score NOT LIKE "%Not Available%"
UNION ALL
SELECT
  ec.provider_id,
  ec.measure_id,
  cast(ec.score as smallint) as score
FROM effective_care_hospital ec
INNER JOIN hospitals h
	on ec.provider_id = h.provider_id
WHERE ec.measure_id NOT IN ("VTE_1", "VTE_2", "VTE_3", "VTE_4", "CAC_1", "CAC_2", "CAC_3", "ED_1b", "ED_2b", "EDV", "OP_18b", "OP_21",
	 "OP_22", "AMI_7a", "OP_1", "OP_2", "HF_2", "STK_8", "OP_6", "OP_7", "SCIP_INF_1", "SCIP_INF_2", "SCIP_INF_3", "SCIP_INF_4")
	AND ec.score NOT LIKE "%Not Available%"
	AND ec.footnote NOT LIKE "%1 - The number of cases/patients is too few to report.%"
	AND ec.footnote <> "11 - There were discrepancies in the data collection process.";