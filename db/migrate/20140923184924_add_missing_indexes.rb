class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :instagram_media_hashtags, :instagram_media_id
    add_index :instagram_media_hashtags, [:hashtag_id, :instagram_media_id], name: 'index_imh_on_hashtag_id_and_instagram_media_id'
  end
end