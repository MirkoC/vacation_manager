class Vacation < ApplicationRecord
  belongs_to :vacationable, polymorphic: true, validate: true

  validates :vacationable, :start_date, :end_date, presence: true
end
