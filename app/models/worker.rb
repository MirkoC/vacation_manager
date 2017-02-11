class Worker < ApplicationRecord
  include VacationableHelpers

  has_many :vacations, as: :vacationable, autosave: true, dependent: :destroy

  validates :full_name, :email, presence: true
end
