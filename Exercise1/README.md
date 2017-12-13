## Exercise 1

# Inital Setup
1. Start up your AWS machine with the appropriate technology installed
[only needs to be done once] Follow steps 1-3 (through 'Download and Run the Setup Script') on https://github.com/UC-Berkeley-I-School/w205-fall-17-labs-exercises/blob/master/lab_2/Lab2.md to start an appropriate AWS instance.
[Already set up the AWS machine previously] Start the EC2 instance, ssh in to it, and mount your drive as /data.
2. Pull Exercise1 repository in EC2 instance (`git clone https://github.com/PageJewel/W205/Exercise1.git`).
3. Create a directory Exercise1/data - type `mkdir data` from Exercise1 folder.
4. Move the flat files into Exercise1/data if you already have them. Otherwise:
- In Exercise1/data, download the data by typing `wget -O Hospital_Revised_Flatfiles.zip "https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3\Dbinary&filename=Hospital_Revised_Flatfiles.zip"`
- Unzip the downloaded data by typing `unzip Hospital_Revised_Flatfiles.zip`
5. Open permissions on these files so the w205 user can access them. Type `chmod 007 *`. Also grant access to the entire folder so w205 can create files - `chmod 007 ../data/`.

# Clean the data files and load into HDFS directory
6. Start Hadoop (type `/root/start-hadoop.sh`) and postgres (type `/data/start_postgres.sh`) in EC2 instance. Switch to w205 user by typing `su - w205`. Start Hive metastore (type `/data/start_metastore.sh`) in EC2 instance.
7. Go to Exercise1/loading_and_modelling, and type `. load_data_lake.sh`. This processes the data files and loads them into the hdfs file structure.
8. Type `hive -f hive_base_ddl.sql`. This creates the Hive metadata for the tables.

# Transform the data
9. Go to Exercise1/transforming.
10. Type `hive -f hospitals.sql`. This creates the hospitals table from the ER diagram.
11. Type `hive -f hospital_procedure_scores_temp.sql`. This generates an intermediate cleaned table of scores by measure for each hospital.
12. Type `hive -f procedures.sql`. This creates the procedures table from the ER diagram.
13. Type `hive -f hospital_procedure_scores.sql`. This creates the final hospital_procedure_scores table from the ER diagram.
14. Type `hive -f survey_results.sql`. This creates the survey_results table from the ER diagram.

# Return results
15. Go to Exercise1/investigations.
16. Type `hive -f best_hospitals/best_hospitals.sql` to return the top 10 hospitals with consistently high quality
17. Type `hive -f best_states/best_states.sql` to return the top 10 states with consistently high quality
18. Type `hive -f hospital_variability/hospital_variability.sql` to return the top 10 procedures with the most variation between hospitals
19. Type `hive -f hospitals_and_patients/hospitals_and_patients.sql` to return the results of whether average scores for hospital quality or procedural variability are correlated with patient survey responses.