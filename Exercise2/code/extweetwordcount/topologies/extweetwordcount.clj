(ns extweetwordcount
  (:use     [streamparse.specs])
  (:gen-class))

(defn extweetwordcount [options]
   [
    ;; spout configuration
    {"tweet-spout" (python-spout-spec
          options
          "spouts.tweets.Tweets"
          ["tweet"]
          :p 1
          )
    }
    ;; bolt configuration
    {"parse-tweet-bolt" (python-bolt-spec
          options
          {"tweet-spout" :global}
          "bolts.parse.ParseTweet"
          ["valid_words"]
          :p 1
          )
     "count-bolt" (python-bolt-spec
          options
          {"parse-tweet-bolt" :global}
          "bolts.wordcount.WordCounter"
          ["word" "count"]
          :p 1
          )
    }
  ]
)
