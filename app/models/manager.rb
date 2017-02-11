class Manager < ApplicationRecord
  include VacationableHelpers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :vacations, as: :vacationable, autosave: true, dependent: :destroy

  validates :full_name, presence: true

  def new_jwt
    JsonWebToken.encode(email: email)
  end
end
