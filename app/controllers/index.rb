enable :sessions
set :protection, except: :session_hijacking
require 'twitter'

get '/' do

  erb :index
end

get '/:username' do
  @user = Twitteruser.find_by_username(params[:username])
  if @user.tweets.empty?
    @user.fetch_tweets!
  elsif @user.tweets_stale?
    @user.fetch_tweets!
  end
  @tweets = @user.tweets.limit(10)
  erb :tweets
end


post '/tweets' do
  @tweets = $client.user_timeline(params[:username])
  erb :tweets
end