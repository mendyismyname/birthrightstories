# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'birthrightstories'
set :repo_url, 'git@github.com:mendyismyname/birthrightstories.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :tmp_dir, '/home/rails/tmp'
set :deploy_to, "/home/rails/birthrightstories"
set :deploy_via, :remote_cache
set :keep_releases, 20

set :linked_files, %w{config/database.yml config/config.yml}
set :linked_dirs, %w{bin log tmp vendor/bundle public/assets public/system public/uploads}

set :rvm_ruby_version, '2.0.0-p353'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }


SSHKit.config.command_map[:rake]  = "bundle exec rake"
SSHKit.config.command_map[:rails] = "bundle exec rails"

# Delayed Jobs config
# set :delayed_job_server_role, :worker
# set :delayed_job_args, "-n 2"

# Whenever settings for CRON
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

##########################################
# INSTALL
##########################################
namespace :install do
  # READ BOTH OF THESE
  # https://www.digitalocean.com/community/articles/how-to-launch-your-ruby-on-rails-app-with-the-digitalocean-one-click-image
  # https://www.digitalocean.com/community/articles/how-to-1-click-install-ruby-on-rails-on-ubuntu-12-10-with-digitalocean
  desc "Primary setup"
  task :dependencies do
    on roles(:app) do
      sudo "apt-get -y update"
      sudo "apt-get -y install python-software-properties"
      sudo "apt-get install -y git"
      sudo "apt-get install -y nodejs"
      sudo "apt-get install -y memcached"
      sudo "apt-get install -y imagemagick"
      sudo "apt-get install -y libmagickwand-dev"
      # invoke 'redis:install'
      execute 'rvm get stable'

      # Manually
      # CREATE DATABASE birthrightstories_staging; GRANT all privileges ON birthrightstories_staging.* TO 'rails'@'localhost' IDENTIFIED BY 'F77a7oA2SO';
      
      # Fix RVM integration with Whenever bug
      # execute 'echo rvm_trust_rvmrcs_flag=1 >> ~/.rvmrc'
    end
  end
  task :server_config do
    on roles(:app) do
      upload! 'config/digital_ocean/my.cnf', '/root/my.cnf'
      upload! 'config/digital_ocean/nginx_birthrightstories.conf', '/etc/nginx/sites-enabled/birthrightstories'
      upload! 'config/digital_ocean/nginx.conf', '/etc/nginx/sites-enabled/birthrightstories'
      # upload! 'config/digital_ocean/nginx.conf', '/etc/nginx/nginx.conf'
      upload! 'config/digital_ocean/unicorn.rb', '/home/unicorn/unicorn.conf'
      upload! 'config/digital_ocean/unicorn_init.sh', '/etc/init.d/unicorn'
      upload! 'config/digital_ocean/unicorn_paths.sh', '/etc/default/unicorn'
    end
  end
  task :rails_config do
    on roles(:app) do
      # execute 'mkdir /home/rails/birthrightstories'
      # execute 'mkdir /home/rails/birthrightstories/shared'
      # execute 'mkdir /home/rails/birthrightstories/shared/config'

      # execute 'cp /home/rails/birthrightstories/shared/config/config.yml /home/rails/birthrightstories/shared/config/config.backup.yml'
      # execute 'cp /home/rails/birthrightstories/shared/config/database.yml /home/rails/birthrightstories/shared/config/database.backup.yml'

      upload! 'config/config.yml', '/home/rails/birthrightstories/shared/config/config.yml'
      upload! 'config/database.yml', '/home/rails/birthrightstories/shared/config/database.yml'
    end
  end
end

##########################################
# DEPLOYMENT
##########################################
namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'install:rails_config'
      # invoke 'delayed_job:restart' 
      invoke 'unicorn:stop'
      invoke 'unicorn:start'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end


