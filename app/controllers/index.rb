enable :sessions
set :protection, except: :session_hijacking
require 'twitter'

get '/' do

  erb :index
end


# get '/newtweets' do
#   @user = Twitteruser.find_by_username(params[:username])
#   puts @user.fetch_tweets!
#   @tweets = @user.tweets

#   erb :tweets_loading, :layout => false
# end

get '/newtweets' do
  @user = Twitteruser.find_by_username(params[:username])
  puts @user
  if @user.tweets.empty?
    @user.fetch_tweets!
    @tweets = @user.tweets.order("id DESC").limit(10)
    erb :tweets, :layout => false
  elsif @user.tweets_stale?
    @user.fetch_tweets!
    @tweets = @user.tweets.order("id DESC").limit(10)
    erb :tweets_loading, :layout => false
  else
    erb :tweets
  end
end

get '/:username' do
  @user = Twitteruser.find_by_username(params[:username])
  if @user.tweets.empty?
    @user.fetch_tweets!
    @tweets = @user.tweets.order("id DESC").limit(10)
    erb :tweets
  elsif @user.tweets_stale?
    puts "It runs"
    @user.fetch_tweets!
    @tweets = @user.tweets.order("id DESC").limit(10)
    erb :tweets_loading
  else
    erb :tweets
  end
end





# get '/show_tweets/:username' do
#   @user = Twitteruser.find_by_username(params[:username])
#   @tweets = @user.tweets.limit(10)
#   # @user.fetch_tweets!
#   erb :tweets_loading
# end

