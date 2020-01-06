# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Learn more: http://github.com/javan/whenever

set :environment, "development"
set :output, "/crawler/config/import_log.log"
every 1.day at: '4:00 pm' do
  rake "job:create"
end
