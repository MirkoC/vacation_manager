class YearlyVacationSchedulerJob < ApplicationJob
  queue_as :default

  def perform
    Manager.all.each do |manager|
      ApplicationMailer.yearly_reminder_(manager).deliver
    end
    Worker.all.each do |worker|
      ApplicationMailer.yearly_reminder(worker).deliver
    end
  end
end
