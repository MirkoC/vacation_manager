module VacationableHelpers
  extend ActiveSupport::Concern

  def vacation_days_left(year=nil)
    enquired_year = year ? year.to_s : Date.today.strftime('%Y')
    vacations = Vacation.where(vacationable: self)
                .where('EXTRACT(year from end_date) = ? OR EXTRACT(year from start_date) = ?', enquired_year, enquired_year)
    days_left = 30
    vacations.each do |vacation|
      (vacation.start_date..vacation.end_date).each do |vac_dates|
        next if vac_dates.strftime('%Y') != enquired_year
        days_left -= 1
      end
    end

    days_left
  end

  def vacation_times_left(year=nil)
    enquired_year = year ? year.to_s : Date.today.strftime('%Y')
    3 - Vacation.where(vacationable: self)
                .where('EXTRACT(year from end_date) = ? OR EXTRACT(year from start_date) = ?', enquired_year, enquired_year).count
  end

  def active_vacation
    vacation = Vacation.where(vacationable: self).order(end_date: :desc).first
    vacation.end_date >= Date.today ? vacation : nil if vacation
  end

  def last_vacation
    Vacation.where(vacationable: self).order(end_date: :desc).first
  end
end
