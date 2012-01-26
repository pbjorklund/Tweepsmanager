class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :image_url
      t.string :nickname
      t.string :bio
      t.string :last_tweet

      t.timestamps
    end
  end
end
