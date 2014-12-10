class CreateTwitterusers < ActiveRecord::Migration
  def change
    create_table :twitterusers do |t|
      t.string :username, null: false
      t.timestamps
    end
  end
end
