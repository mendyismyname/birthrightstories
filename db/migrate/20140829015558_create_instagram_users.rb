class CreateInstagramUsers < ActiveRecord::Migration
  def change
    create_table :instagram_users do |t|
      t.integer :instagram_id
      t.string :username
      t.string :full_name
      t.text :bio
      t.string :profile_picture
      t.string :website
      t.integer :media_count
      t.integer :follows_count
      t.integer :followed_by_count

      t.timestamps
    end
  end
end
