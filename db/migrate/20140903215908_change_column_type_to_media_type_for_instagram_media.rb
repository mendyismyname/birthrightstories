class ChangeColumnTypeToMediaTypeForInstagramMedia < ActiveRecord::Migration
  def change
    remove_column :instagram_media, :type
    add_column :instagram_media, :media_type, :string

  end
end
