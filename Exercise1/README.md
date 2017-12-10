## Exercise 1

# Inital Setup
1. Pull Exercise1 repository in EC2 instance (`git clone https://github.com/PageJewel/W205/Exercise1.git`).
2. Create a directory Exercise1/data - type `mkdir data` from Exercise1 folder.
3. Move the flat files into Exercise1/data if you already have them. Otherwise:
- In Exercise1/data, download the data by typing `wget -O Hospital_Revised_Flatfiles.zip "https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3\Dbinary&filename=Hospital_Revised_Flatfiles.zip"`
- Unzip the downloaded data by typing `unzip Hospital_Revised_Flatfiles.zip`
4. Open permissions on these files so the w205 user can access them. Type `chmod 007 *`. Also grant access to the entire folder so w205 can create files - `chmod 007 ../data/`.

# Clean the data files and load into HDFS directory
4. Start Hadoop and postgres in EC2 instance. Switch to w205 user by typing `su - w205`. Start Hive metastore in EC2 instance.
5. Go to Exercise1/loading_and_modelling, and type `. load_data_lake.sh`. This processes the data files and loads them into the hdfs file structure. It also switches the user from root to w205 as it begins the hdfs steps.

# Transform the data
