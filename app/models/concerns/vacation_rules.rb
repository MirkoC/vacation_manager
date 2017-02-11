module VacationRules
  extend ActiveSupport::Concern

  def can_start_vacation
    return unless vacationable
    return unless end_date && start_date
    return errors.add(:base, "#{vacationable_type} already has scheduled vacation") if vacationable.active_vacation
    rule_30_days
    rule_60_days_gap
    send("rule_#{vacationable_type.underscore.pluralize}_on_vacation")
    true
  end

  def rule_30_days
    errors.add(:base, 'Not enough vacation days') if (end_date - start_date).to_i > vacationable.vacation_days_left
    errors.add(:base, 'Vacation too long') if (end_date - start_date).to_i > 30
  end

  def rule_60_days_gap
    errors.add(:base, 'Cannot schedule more than 3 vacation times') if vacationable.vacation_times_left <= 0
    if vacationable.last_vacation
      unless (start_date - vacationable.last_vacation.end_date) > 60
        errors.add(:base, 'Must be 60 days gap between two vacations')
      end
    end
  end

  def rule_workers_on_vacation
    number_of_workers = Worker.count
    return if number_of_workers <= 1
    workers_on_vacations = Worker.joins(:vacations)
                                 .where('(start_date >= ? AND start_date <= ?) OR (end_date >= ? AND end_date <= ?)',
                                        start_date, end_date, start_date, end_date).count
    errors.add(:base, 'Too many workers on vacation') if (workers_on_vacations + 1) / number_of_workers.to_f > 0.5
  end

  def rule_managers_on_vacation
    number_of_managers = Manager.count
    return if number_of_managers <= 1
    managers_on_vacations = Manager.joins(:vacations)
                                   .where('(start_date >= ? AND start_date <= ?) OR (end_date >= ? AND end_date <= ?)',
                                          start_date, end_date, start_date, end_date).count
    errors.add(:base, 'Too many managers on vacation') if (managers_on_vacations + 1) / number_of_managers.to_f > 0.1
  end
end
