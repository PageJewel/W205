## Exercise 1

# Inital Setup
1. Pull Exercise1 repository in EC2 instance (`git clone https://github.com/PageJewel/W205/Exercise1.git`).
2. Create a directory Exercise1/data and place the unzipped data in that directory.

# Clean the data files and load into HDFS directory
3. Type `su - w205`. This switchews from root to w205 user. Start Hadoop, postgres, and Hive in EC2 instance.
4. Go to Exercise1/loading_and_modelling, and type `. load_data_lake.sh`. This processes the data files and loads them into the hdfs file structure.

# Transform the data
