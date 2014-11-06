# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

tag_name = 'taglit'

every 1.days do
  runner "HashtagScraper.fetch_tag_sequence('#{tag_name}')"
  # runner "HashtagAnalytics.save_top_performing_images('#{tag_name}')"
end

every 14.hours do
  runner "InstagramUser.refresh_all"
end
