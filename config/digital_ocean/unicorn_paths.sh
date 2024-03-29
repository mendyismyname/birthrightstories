# Change paramentres below to appropriate values and set CONFIGURED to yes.
CONFIGURED=yes

# Default timeout until child process is killed during server upgrade,
# it has *no* relation to option "timeout" in server's config.rb.
TIMEOUT=60

# Path to your web application, sh'ld be also set in server's config.rb,
# option "working_directory". Rack's config.ru is located here.
APP_ROOT=/home/rails/birthrightstories/current

# Server's config.rb, it's not a rack's config.ru
CONFIG_RB=/home/unicorn/unicorn.conf

# Where to store PID, sh'ld be also set in server's config.rb, option "pid".
PID=/home/unicorn/pids/unicorn.pid
UNICORN_OPTS="-D -c $CONFIG_RB -E production"

#PATH=/usr/local/rvm/rubies/ruby-2.1.2/bin:/usr/local/rvm/gems/ruby-2.1.2/bin:/home/unicorn/.rvm/bin:/usr/local/sbin:/usr/bin:/bin:/sbin:$
PATH=/usr/local/rvm/rubies/ruby-2.0.0-p353/bin:/usr/local/rvm/gems/ruby-2.0.0-p353/bin:/bin:/home/unicorn/.rvm/bin:/usr/local/sbin:/usr/bin:/bin:/sbin:$

