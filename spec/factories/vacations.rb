FactoryGirl.define do
  factory :vacation do
    start_date { Faker::Date.between(5.days.ago, 1.day.ago) }
    end_date { Faker::Date.between(1.days.from_now, 5.days.from_now) }
  end
end
