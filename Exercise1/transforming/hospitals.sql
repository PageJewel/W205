DROP TABLE hospitals;
CREATE TABLE hospitals AS
SELECT
  provider_id,
  hospital_name,
  city,
  state,
  hospital_type,
  hospital_ownership,
  emergency_services
FROM hospital_info
WHERE hospital_type NOT IN ("ACUTE CARE - VETERANS ADMINISTRATION", "Childrens");