class ChangeColumnMinTagIdOnHashtag < ActiveRecord::Migration
  def change
    change_column :hashtags, :min_tag_id, :string, default: '0'
  end
end
