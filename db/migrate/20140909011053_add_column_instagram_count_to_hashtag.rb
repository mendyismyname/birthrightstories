class AddColumnInstagramCountToHashtag < ActiveRecord::Migration
  def change
    add_column :hashtags, :instagram_count, :integer, default: 0
  end
end
