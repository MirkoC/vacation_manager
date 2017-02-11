require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.cron '* * 1 4 *' do
  YearlyVacationSchedulerJob.perform_later
end
