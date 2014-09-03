class ChangeIdTypeForInstagramMedia < ActiveRecord::Migration
  def change
    change_column :instagram_media, :instagram_id, :string
  end
end
