from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()
	
try:
	conn = psycopg2.connect(database="postgres", user="postgres", password="pass", host="localhost", port="5432")
except:
	print 'failed to connect'

	cur = conn.cursor()
	cur.execute("SELECT word, count from tweetwordcount")
	records = cur.fetchall()
	for rec in records:
   		print "word = ", rec[0]
   		print "count = ", rec[1], "\n"
	conn.commit()

	conn.close()

    def process(self, tup):
        word = tup.values[0]

        # Write codes to increment the word count in Postgres
        # Use psycopg to interact with Postgres
        # Database name: Tcount 
        # Table name: Tweetwordcount 
        # you need to create both the database and the table in advance.
        

        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
