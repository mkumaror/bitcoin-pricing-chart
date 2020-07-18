# Use below command to update the contab for development environment
# -------------------------------------------------------
# whenever --update-crontab --set environment=development
# -------------------------------------------------------

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "log/cron_log.log"
#

every 1.minute do # 1.minute 1.day 1.week 1.month 1.year is also supported
  rake "fetch:latest_pricing"
end

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
