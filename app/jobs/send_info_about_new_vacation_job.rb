class SendInfoAboutNewVacationJob < ApplicationJob
  queue_as :default

  def perform(vacation_id, initiating_manager_id)
    vacation = Vacation.find_by_id(vacation_id)
    initiating_manager = Manager.find_by_id(initiating_manager_id)
    Manager.all.each do |manager|
      ApplicationMailer.new_vacation(vacation, initiating_manager, manager).deliver
    end
  end
end
