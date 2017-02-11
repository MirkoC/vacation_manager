class ApplicationMailer < ActionMailer::Base
  default from: 'mirko.cerovac@gmail.com'
  layout 'mailer'

  def new_vacation(vacation, initiating_manager, manager)
    @vacation = vacation
    @initiating_manager = initiating_manager
    @manager = manager

    mail(to: manager.email,
         subject: "#{initiating_manager.full_name} approved vacation for #{vacation.vacationable.full_name}",
         content_type: 'text/html')
  end

  def yearly_reminder(vacationable)
    @vacationable = vacationable

    mail(to: vacationable.email,
         subject: 'Yearly reminder to schedule vacations',
         content_type: 'text/html')
  end
end
