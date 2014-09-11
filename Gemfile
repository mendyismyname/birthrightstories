source 'https://rubygems.org'

ruby '2.0.0'


# Core
gem 'rails', '4.1.5'
gem 'mysql2'
gem 'react-rails', '~> 0.5.1'

# Webserver
group :staging, :production do
  gem 'unicorn', '4.8.3'
end
group :development do
  gem 'thin'
end

# Primary
gem 'possibly', '~> 0.1.1' # Maybe monad
gem 'friendly_id'
gem 'decent_exposure'

# Localization
gem 'http_accept_language'
gem 'rails-i18n', '~> 4.0.0'
gem 'rails-translate-routes'

# Sharepoint
# gem 'sharepoint-ruby'

# Emojis
# gem 'demoji'

# Instagram
gem 'instagram'

# Admin Panel
gem 'devise' # Needed for activeadmin
gem 'activeadmin', github: 'activeadmin'


# # Background Processing
gem 'daemons'
gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'whenever', :require => false

# Pagination
gem 'kaminari'

# Caching
gem 'dalli'
gem 'multi_fetch_fragments'

####################################
# ASSETS
####################################
gem 'haml-rails'
gem 'sass-rails', '>= 4.0.0'
gem 'coffee-rails'
gem 'uglifier'

gem 'sprockets', '2.11.0'  # Needed to fix stylesheet bug 2 for 1 arguments

# Design
gem 'normalize-rails'
gem 'neat',    '~> 1.6.0'
gem 'bourbon', '>= 4.0.2'
gem 'bitters'
gem 'refills'

# JS
gem 'jquery-rails'
# gem 'jquery-turbolinks'
# gem 'turbolinks'
# gem 'turbolinks-redirect'
gem 'masonry-rails'
gem "jquery-scrollto-rails"

####################################
# DEVELOPMENT
####################################

group :test, :development do
  gem 'awesome_print'
  gem 'jazz_hands'
  gem 'quiet_assets'
end

# Productivity
group :development do
  gem 'spring'
  gem 'guard',            require: false
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'better_errors'     # Better Errors
  gem 'binding_of_caller' # Better Errors
  gem 'meta_request'      # RailsPanel
  gem 'terminal-notifier-guard'
end

# Deployment
group :development do
  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  gem 'capistrano-rails-collection'
end

# Database tools
group :development do
  gem 'annotate' # Annotates activerecord fields
end
