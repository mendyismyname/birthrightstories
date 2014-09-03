class AddSlugToHashtag < ActiveRecord::Migration
  def change
    add_column :hashtags, :slug, :string
    add_index :hashtags, :slug, unique: true
  end
end
