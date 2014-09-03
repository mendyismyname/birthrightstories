class CreateInstagramMedia < ActiveRecord::Migration
  def change
    create_table :instagram_media do |t|
      t.string :type
      t.text :users_in_photo
      t.string :filter
      t.text :tags
      t.text :comments
      t.string :caption
      t.text :likes
      t.datetime :created_time
      t.text :images
      t.integer :instagram_id
      t.string :location
      t.text :videos

      t.timestamps
    end
  end
end
