class CreateInstagramMediaHashtags < ActiveRecord::Migration
  def change
    create_table :instagram_media_hashtags do |t|
      t.integer :instagram_media_id
      t.integer :hashtag_id

      t.timestamps
    end

    add_index :instagram_media_hashtags, :hashtag_id
  end
end
