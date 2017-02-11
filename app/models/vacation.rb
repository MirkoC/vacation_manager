class Vacation < ApplicationRecord
  include VacationRules

  belongs_to :vacationable, polymorphic: true, validate: true

  validates :vacationable, :start_date, :end_date, presence: true
  validate :can_start_vacation
end
