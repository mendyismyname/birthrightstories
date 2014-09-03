class AddInstagramUserIdToInstagramMedia < ActiveRecord::Migration
  def change
    add_column :instagram_media, :instagram_user_id, :string
  end
end
