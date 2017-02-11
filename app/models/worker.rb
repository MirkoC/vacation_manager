class Worker < ApplicationRecord
  has_many :vacations, as: :vacationable, autosave: true, dependent: :destroy

  validates :full_name, presence: true
end
