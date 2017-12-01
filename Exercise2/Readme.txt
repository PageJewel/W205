Instructions on how to set up and run the application

1. Start up your AWS machine with the appropriate technology installed
[only needs to be done once] Follow steps 1-3 (through 'Download and Run the Setup Script') on https://github.com/UC-Berkeley-I-School/w205-fall-17-labs-exercises/blob/master/lab_2/Lab2.md to start an appropriate AWS instance. In Step 1, instead of using AMI 'UCB W205 Spring 2016' use the AMI 'UCB MIDS W205 EX2-FULL' which has streamparse already installed.

If you have already set up the AWS machine previously, you just need to start the EC2 instance, ssh in to it, and mount your drive as /data.

[only needs to be done once] 2. Install a couple additional components
Run the following for connecting python to postgres and for connecting to twitter:
pip install psycopg2
pip install tweepy
pip install requests[security]

3. Start Postgres running and set up basic table structure
First, run the following to start up postgres: /data/start_postgres.sh
Then, get a psql prompt with the following: psql -U postgres

[only needs to be done once] Run the following two commands to create your database and table:
CREATE DATABASE tcount;
CREATE TABLE tweetwordcount
       (word TEXT PRIMARY KEY     NOT NULL,
       count INT     NOT NULL);

[only needs to be done once] 4. Download the code into /data/exercise2/ 
All code to run the application lives in: https://github.com/PageJewel/W205/tree/master/Exercise2/code

5. Start the application
Go to /data/exercise2/extweetwordcount
From the command line run the following: sparse run
When prompted, hit enter to continue running as root user

6. Access results
There are a couple ways to access the results as the application parses the twitter stream data:
- use your psql command line to run queries against the tweetwordcount table
- from the command line in /data/exercise2, run the following to get back the count for a word of interest: python finalresults.py <word of interest>
- from the command line in /data/exercise2, run the following to get back all words with a count in the range of interest: python histogram.py <inclusive lower bound> <inclusive upper bound> 

7. Shut it down
From the command line where your streamparse app is running (from step 5), hit cntrl+c
To exit any psql prompts that you have open, run the following: \q
To shut down postgres, run: /data/stop_postgres.sh
Through the AWS console, stop the EC2 instance