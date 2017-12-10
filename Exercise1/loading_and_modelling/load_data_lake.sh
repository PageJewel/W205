# Process and load data files into hdfs data lake

# Process files from data directory - rename and remove header row
cd ../data

tail -n +2 "Readmissions and Deaths - Hospital.csv" > readmit_deaths_hospital.csv
tail -n +2 "Readmissions and Deaths - State.csv" > readmit_deaths_state.csv
tail -n +2 "Timely and Effective Care - Hospital.csv" > effective_care_hospital.csv
tail -n +2 "Timely and Effective Care - State.csv" > effective_care_state.csv
tail -n +2 "Hospital General Information.csv" > hospital_info.csv
tail -n +2 "hvbp_hcahps_05_28_2015.csv" > survey_responses.csv

# Switch user
su - w205

# create hdfs folder structure
hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/readmit_deaths_hospital
hdfs dfs -mkdir /user/w205/hospital_compare/readmit_deaths_state
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care_hospital
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care_state
hdfs dfs -mkdir /user/w205/hospital_compare/hospital_info
hdfs dfs -mkdir /user/w205/hospital_compare/survey_responses

# Place processed files into hdfs structure
hdfs dfs -put readmit_deaths_hospital.csv /user/w205/hospital_compare/readmit_deaths_hospital
hdfs dfs -put readmit_deaths_state.csv /user/w205/hospital_compare/readmit_deaths_state
hdfs dfs -put effective_care_hospital.csv /user/w205/hospital_compare/effective_care_hospital
hdfs dfs -put effective_care_state.csv /user/w205/hospital_compare/effective_care_state
hdfs dfs -put hospital_info.csv /user/w205/hospital_compare/hospital_info
hdfs dfs -put survey_responses.csv /user/w205/hospital_compare/survey_responses

# Switch back to initial directory
cd ../loading_and_modelling