class AddColumnMinTagIdAndMaxTagIdToHasthtag < ActiveRecord::Migration
  def change
    add_column :hashtags, :min_tag_id, :integer
    add_column :hashtags, :max_tag_id, :integer
  end
end
