## Exercise 1

# Inital Setup
1. Pull Exercise1 repository in EC2 instance (`git clone https://github.com/PageJewel/W205/Exercise1.git`).
2. Create a directory Exercise1/data - type `mkdir data` from Exercise1 folder.
3. Move the flat files into Exercise1/data if you already have them. Otherwise:
- In Exercise1/data, download the data by typing `wget -O Hospital_Revised_Flatfiles.zip "https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3\Dbinary&filename=Hospital_Revised_Flatfiles.zip"`
- Unzip the downloaded data by typing `unzip Hospital_Revised_Flatfiles.zip`
4. Open permissions on these files so the w205 user can access them. Type `chmod 007 *`. Also grant access to the entire folder so w205 can create files - `chmod 007 ../data/`.

# Clean the data files and load into HDFS directory
5. Start Hadoop and postgres in EC2 instance. Switch to w205 user by typing `su - w205`. Start Hive metastore in EC2 instance.
6. Go to Exercise1/loading_and_modelling, and type `. load_data_lake.sh`. This processes the data files and loads them into the hdfs file structure.
7. Type `hive -f hive_base_ddl.sql`. This creates the Hive metadata for the tables.

# Transform the data
8. Go to Exercise1/transforming.
9. Type `hive -f hospitals.sql`. This creates the hospitals table from the ER diagram.
10. Type `hive -f hospital_procedure_scores_temp.sql`. This generates an intermediate cleaned table of scores by measure for each hospital.
11. Type `hive -f procedures.sql`. This creates the procedures table from the ER diagram.
12. Type `hive -f hospital_procedure_scores.sql`. This creates the final hospital_procedure_scores table from the ER diagram.
13. Type `hive -f survey_responses.sql`. This creates the survey_results table from the ER diagram.

# Return results
14. Go to Exercise1/investigations.
15. Type `hive -f best_hospitals.sql` to return the top 10 hospitals with consistently high quality
16. Type `hive -f best_states.sql` to return the top 10 states with consistently high quality
17. Type `hive -f hospital_variability.sql` to return the top 10 procedures with the most variation between hospitals
18. Type `hive -f hospitals_and_patients.sql` to return the results of whether average scores for hospital quality or procedural variability are correlated with patient survey responses.