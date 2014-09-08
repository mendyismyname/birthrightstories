class AddColumnIsActiveToHashtag < ActiveRecord::Migration
  def change
    add_column :hashtags, :is_active, :boolean, default: true
  end
end
