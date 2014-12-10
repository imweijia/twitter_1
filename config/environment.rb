# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'

require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'mini_magick'

require 'twitter'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'uploaders', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

# Set up carrierwave
CarrierWave.configure do |config|
  # your configuration code goes here
  config.root = APP_ROOT + 'public/'
  # config.permissions = 0666
  # config.directory_permissions = 0777
  # config.storage = :file

  # def store_dir
  #   "/home/codedivision/Desktop/w5d4/flickr/photos"
  # end
end

$client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "m51hixpCWZU2PfoplRGDx2iMY"
    config.consumer_secret     = "YQ86Oy0YzCYhMFBmfJzeOa2TOj5F8zHeDxDM06ttYZrAPtEwgt"
    config.access_token        = "2907339704-pJm2jsXhTnFw6as3RKFrYNzuPIwJDLpH8VVJOwJ"
    config.access_token_secret = "hb3vWnzB3WGnRfFNkK0WWw26Ug6dA547vaB1Hkbz1Y65m"
end