#!/bin/sh
### BEGIN INIT INFO
# Provides:          unicorn
# Required-Start:    $local_fs $remote_fs
# Required-Stop:     $local_fs $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: unicorn initscript
# Description:       unicorn
### END INIT INFO

set -e
NAME=unicorn
DESC="Unicorn web server"

. /lib/lsb/init-functions

if [ -f /etc/default/unicorn ]; then
  . /etc/default/unicorn
fi

export GEM_HOME=/usr/local/rvm/gems/ruby-2.0.0-p353
export GEM_PATH=/usr/local/rvm/gems/ruby-2.0.0-p353:/usr/local/rvm/gems/ruby-2.0.0-p353/gems:/usr/local/rvm/gems/ruby-2.0.0-p353@global/gems
DAEMON=/usr/local/rvm/gems/ruby-2.0.0-p353/bin/unicorn

# export GEM_HOME=/usr/local/rvm/gems/ruby-2.1.2
# export GEM_PATH=/usr/local/rvm/gems/ruby-2.1.2:/usr/local/rvm/gems/ruby-2.1.2/gems:/usr/local/rvm/gems/ruby-2.1.2@global/gems
# DAEMON=/usr/local/rvm/gems/ruby-2.1.2/bin/unicorn

PID=${PID-/run/unicorn.pid}

run_by_init() {
    ([ "${previous-}" ] && [ "${runlevel-}" ]) || [ "${runlevel-}" = S ]
}

exit_with_message() {
  if ! run_by_init; then
    log_action_msg "$1 Not starting."
  fi
  exit 0
}

check_config() {
  if [ $CONFIGURED != "yes" ]; then
    exit_with_message "Unicorn is not configured (see /etc/default/unicorn)."
  fi
}

check_app_root() {
  if ! [ -d $APP_ROOT ]; then
    exit_with_message "Application directory $APP_ROOT is not exist."
  fi
}

set -u

case "$1" in
  start)
        check_config
        check_app_root

        log_daemon_msg "Starting $DESC" $NAME || true
        if start-stop-daemon --start --quiet --oknodo --pidfile $PID --exec $DAEMON -- $UNICORN_OPTS; then
          log_end_msg 0 || true
        else
          log_end_msg 1 || true
        fi
        ;;
  stop)
        log_daemon_msg "Stopping $DESC" $NAME || true
        if start-stop-daemon --stop --signal QUIT --quiet --oknodo --pidfile $PID; then
          log_end_msg 0 || true
        else
          log_end_msg 1 || true
        fi
        ;;
  force-stop)
        log_daemon_msg "Forcing stop of $DESC" $NAME || true
        if start-stop-daemon --stop --quiet --oknodo --pidfile $PID; then
          log_end_msg 0 || true
        else
          log_end_msg 1 || true
        fi
        ;;
  restart|force-reload)
        log_daemon_msg "Restarting $DESC" $NAME || true
        start-stop-daemon --stop --quiet --oknodo --pidfile $PID
        sleep 1
        if start-stop-daemon --start --quiet --oknodo --pidfile $PID --exec $DAEMON -- $UNICORN_OPTS; then
          log_end_msg 0 || true
        else
          log_end_msg 1 || true
        fi
        ;;
  reload)
        log_daemon_msg "Reloading $DESC" $NAME || true
        if start-stop-daemon --stop --signal HUP --quiet --oknodo --pidfile $PID; then
          log_end_msg 0 || true
        else
          log_end_msg 1 || true
        fi
        ;;
  reopen-logs)
        log_daemon_msg "Relopening log files of $DESC" $NAME || true
        if start-stop-daemon --stop --signal USR1 --quiet --oknodo --pidfile $PID; then
          log_end_msg 0 || true
        else
          log_end_msg 1 || true
        fi
        ;;
  status)
        status_of_proc -p $PID $DAEMON $NAME && exit 0 || exit $?
        ;;
  *)
        log_action_msg "Usage: $0 <start|stop|restart|force-reload|reload|force-stop|reopen-logs|status>" || true
        exit 1
        ;;
esac
