class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :twitteruser
      t.string :text
      t.datetime :time_created
      t.timestamps
    end
  end
end
