import org.apache.spark._
import org.apache.spark.storage._
import org.apache.spark.streaming._
import org.apache.spark.streaming.twitter.TwitterUtils

import scala.math.Ordering

import twitter4j.auth.OAuthAuthorization
import twitter4j.conf.ConfigurationBuilder

object Main extends App {


        if (args.length != 3) {
                println(s"The number of arguments is", args.length, s" but needs to be 3")
                Console.err.println("Usage: replacer <search> <replace>")
                System.exit(1)
        }

        def toInt(s: String): Option[Int] = {
                try {
                        Some(s.toInt)
                } catch {
                        case e: Exception => None
                }
        }

        // your code goes here
        System.setProperty("twitter4j.oauth.consumerKey", "0X3iV4MDz7jyhosbA8RjnYoC6")
        System.setProperty("twitter4j.oauth.consumerSecret", "m1TYeoSPdS98ZvjgFRsQNJYLzNxfwxBXLLOzFtSvbkD5oybPis")
        System.setProperty("twitter4j.oauth.accessToken", "285069938-fkmaf8jxkW79K2UgiPNXjmoNze7lidZJdpoxdQHC")
        System.setProperty("twitter4j.oauth.accessTokenSecret", "IoOJnvQybUgb8kdQZLwdH9w8kQRWEwfnHxHGjEvKNjoPI")

        // Directory to output top hashtags
        val outputDirectory = "/twitter"

        // Recompute the top hashtags every 10 seconds
        val intervalString = toInt(args(0))
        val intervalInt = intervalString.getOrElse(10)
        val slideInterval = new Duration(intervalInt * 1000)

        // Compute the top hashtags for the last 30 seconds
        val computeString = toInt(args(1))
        val computeInt = computeString.getOrElse(20)
        val windowLength = new Duration(computeInt * 1000)

        // Wait 600 seconds before stopping the streaming job
        val overallString = toInt(args(2))
        val overallInt = overallString.getOrElse(30)
        val timeoutJobLength = overallInt * 1000

        // Create a streaming context
        // This is the main entry point for all Spark Streaming
        val sparkConfig = new SparkConf().setAppName("Spark Twitter Example")
        val ssc = new StreamingContext(sparkConfig, Seconds(1))

        // Create a stream of tweets
        val tweets = TwitterUtils.createStream(ssc, None)

        // Get only the English Tweets
        val englishTweets = tweets.filter(_.getLang=="en")

        // Parse the tweets and gather the hashTags.
        val hashTagStream = englishTweets.map(_.getText).flatMap(_.split(" ")).filter(x => ((.startsWith("#")% || (.startsWith("@")))))

        val windowedhashTagCountStream = hashTagStream.map((_, 1)).reduceByKey(_+_).reduceByKeyAndWindow((x:Int, y:Int) => x + y, windowLength, slideInterval)

        var numTags = 0
        // For each window, report the top 20 hashtags for that time period.
        windowedhashTagCountStream.foreachRDD(hashTagCountRDD => {
                val topEndpoints = hashTagCountRDD.top(20)
                hashTagCountRDD.saveAsTextFile("results")
                println("%%%%%%%%% Printing hash tag counts after window number : ", numTags)
                println(topEndpoints.mkString("\n"))
                numTags += 1
        })

        var numRef = 0
        val maxTwitterNameLength = 15
        val tweetText = tweets.map(_.getText)
        val tweetSplit = tweetText.flatMap(_.split(' '))
        val namedUsers = tweetSplit.filter(_.startsWith("@"))

        val namedUserList = namedUsers.map((_, 1)).reduceByKey(_+_).reduceByKeyAndWindow((x:Int, y:Int) => x + y, windowLength, slideInterval)

        // For each window, report the top 20 hashtags for that time period.
        namedUserList.foreachRDD(namedUserRDD => {
                val topNames = namedUserRDD.top(20)
                println("%%%%%%%%% Printing Referred Name for window number : ", numRef)
                println(topNames.mkString("\n"))
                numRef += 1
        })
	
	// Get the User text out
        //val status = englishTweets.map(status => status.getUser.getName())
        val screenName = englishTweets.map(status => status.getUser.getScreenName())

        val windowedScreenName = screenName.map((_, 1)).reduceByKey(_+_).reduceByKeyAndWindow((x:Int, y:Int) => x + y, windowLength, slideInterval)

        var numSender = 0
        // For each window, report the top 20 hashtags for that time period.
        windowedScreenName.foreachRDD(screenNameRDD => {
                val topNames = screenNameRDD.top(20)
                println("%%%%%%%%% Printing Sender Name tags for window number : ", numSender)
                println(topNames.mkString("\n"))
                numSender += 1
        })

        // Tell the context to start running the data
        ssc.start()
        ssc.awaitTerminationOrTimeout(timeoutJobLength)

}

