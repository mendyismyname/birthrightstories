class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.string :name
      t.datetime :refreshed_at

      t.timestamps
    end
  end
end
