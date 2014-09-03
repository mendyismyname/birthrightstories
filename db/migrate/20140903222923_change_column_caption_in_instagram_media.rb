class ChangeColumnCaptionInInstagramMedia < ActiveRecord::Migration
  def change
    change_column :instagram_media, :caption, :text
  end
end
