from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()
	
	#connect to Postgres and delete results from prior runs
	conn = psycopg2.connect(database="postgres", user="postgres", \
		password="pass", host="localhost", port="5432")

	cur = conn.cursor()
        cur.execute("DELETE FROM tweetwordcount");
	conn.commit()

	conn.close()

    def process(self, tup):
	#Set up necessary variables
        word = tup.values[0]
	wordCount = self.counts[word]+1

	#Initialize connection to postgres
	conn = psycopg2.connect(database="postgres", user="postgres", \
		password="pass", host="localhost", port="5432")
	cur = conn.cursor()

	#In Postgres db, insert word if first time, otherwise increment count
	if self.counts[word]==0:
		cur.execute("INSERT INTO tweetwordcount (word, count) \
			VALUES (%s, 1)", (word,));
		conn.commit()

		conn.close()
	else:
		cur.execute("UPDATE tweetwordcount SET count=%s WHERE word=%s", (wordCount, word));
		conn.commit()

		conn.close()

        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
