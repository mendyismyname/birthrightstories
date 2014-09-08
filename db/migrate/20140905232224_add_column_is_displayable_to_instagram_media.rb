class AddColumnIsDisplayableToInstagramMedia < ActiveRecord::Migration
  def change
    add_column :instagram_media, :is_displayable, :boolean, default: false
  end
end
