## Exercise 1

# Inital Setup
1. Pull Exercise1 repository in EC2 instance (`git clone https://github.com/PageJewel/W205/Exercise1.git`).
2. Create a directory Exercise1/data - type `mkdir data` from Exercise1 folder.
3. Move the flat files into Exercise1/data if you already have them. Otherwise:
- In Exercise1/data, download the data by typing `wget -O Hospital_Revised_Flatfiles.zip "https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3\Dbinary&filename=Hospital_Revised_Flatfiles.zip"`
- Unzip the downloaded data by typing `unzip Hospital_Revised_Flatfiles.zip`

# Clean the data files and load into HDFS directory
4. Start Hadoop, postgres, and Hive metastore in EC2 instance.
5. Go to Exercise1/loading_and_modelling, and type `. load_data_lake.sh`. This processes the data files and loads them into the hdfs file structure. It also switches the user from root to w205 as it begins the hdfs steps.

# Transform the data
