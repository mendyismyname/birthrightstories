class DestroyInstagramImages < ActiveRecord::Migration
  def change
    drop_table :instagram_images
  end
end
