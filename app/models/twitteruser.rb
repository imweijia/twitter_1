class Twitteruser < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    tweets = $client.user_timeline(self.username)
    tweets.each do |t|
      Tweet.create(twitteruser_id: self.id, text: t.text, time_created: t.created_at)
    end
  end

  def tweets_stale?
    ((Time.now - self.tweets.first.time_created)/24/60) > ((self.tweets.first.time_created - self.tweets.last.time_created)/self.tweets.count/24/60)
  end

end
