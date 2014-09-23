class AddIndexToInstagramMedia < ActiveRecord::Migration
  def change
    add_index :instagram_media, :instagram_user_id
    add_index :instagram_media, :is_displayable
  end
end
