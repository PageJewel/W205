# File to run a query against twitter stream data stored in postgres
# Will return the number of occurences of a specified word, or if no word specified will return all words and their counts

#import package needed to handle user input
import sys

# import package needed to connect to postgres
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Connect to the database and intialize a cursor to encapsulate the query
conn = psycopg2.connect(database="postgres", user="postgres", \
	password="pass", host="localhost", port="5432")
cur = conn.cursor()


# Determine whether user has provided input

if len(sys.argv)==1:
	# Run query and print list of all words and counts
	cur.execute("SELECT word, count FROM tweetwordcount ORDER BY word ASC");
	records = cur.fetchall()
	for rec in records:
		print "(",rec[0],", ",rec[1],"),"
else:
	# Run query and print count for user provided word
	uWord = sys.argv[1]

	cur.execute("SELECT word, count FROM tweetwordcount WHERE word=%s", (uWord,));
	records = cur.fetchall()
	if len(records)==0:
		print "The word you have provided does not appear"	
	else:
		for rec in records:
			print "Total number of occurences of '", rec[0], "': ", rec[1], "\n"

# Close out connection
conn.commit()
conn.close()
