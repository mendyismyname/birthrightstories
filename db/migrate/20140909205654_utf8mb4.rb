class Utf8mb4 < ActiveRecord::Migration

  UTF8_PAIRS = {
    'active_admin_comments'     => 'body',
    'delayed_jobs'  => 'handler',
    'delayed_jobs'  => 'last_error',
    'instagram_media' => 'users_in_photo',
    'instagram_media' => 'tags',
    'instagram_media' => 'comments',
    'instagram_media' => 'caption',
    'instagram_media' => 'likes',
    'instagram_media' => 'images',
    'instagram_media' => 'videos',
    'instagram_users' => 'bio'
  }

  def self.up
    execute "ALTER DATABASE `#{ActiveRecord::Base.connection.current_database}` CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"

    ActiveRecord::Base.connection.tables.each do |table|
      execute "ALTER TABLE `#{table}` CHARACTER SET = utf8mb4 COLLATE utf8mb4_bin;"
    end

    UTF8_PAIRS.each do |table, col|
      execute "ALTER TABLE `#{table}` CHANGE `#{col}` `#{col}` TEXT  CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL;"
    end

  end

  def self.down
    execute "ALTER DATABASE `#{ActiveRecord::Base.connection.current_database}` CHARACTER SET utf8;"

    ActiveRecord::Base.connection.tables.each do |table|
      execute "ALTER TABLE `#{table}` CHARACTER SET = utf8;"
    end

    UTF8_PAIRS.each do |table, col|
      execute "ALTER TABLE `#{table}` CHANGE `#{col}` `#{col}` TEXT  CHARACTER SET utf8  NULL;"
    end
  end
end