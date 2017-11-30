# File to run a query against twitter stream data stored in postgres
# Will return all words with a total number of occurences within bounds set by user

# import package needed to handle user input
import sys

# import package needed to connect to postgres
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Determine if user has entered valid inputs

if len(sys.argv)<3:
	print "Please provide two input values"

elif (int(sys.argv[1])>0 and int(sys.argv[2])>0 and int(sys.argv[2])>=int(sys.argv[1])):

	# Connect to the database and initialize a cursor to encapsulate the query
	conn = psycopg2.connect(database="postgres", user="postgres", \
		password="pass", host="localhost", port="5432")
	cur = conn.cursor()

	# Run query and print results
	uLowerBound = int(sys.argv[1])
	uUpperBound = int(sys.argv[2])

	cur.execute("SELECT word, count FROM tweetwordcount \
		WHERE count>= %s AND count<= %s \
		ORDER BY count DESC, word ASC", (uLowerBound, uUpperBound));
	records = cur.fetchall()
	for rec in records:
		print rec[0],": ",rec[1]
	
	# Close connection
	conn.commit()
	conn.close()

else:
	print "Please provide two numeric integers greater than 0, starting with the lower value"
