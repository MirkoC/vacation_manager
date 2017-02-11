FactoryGirl.define do
  factory :manager do
    full_name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    email { Faker::Internet.safe_email(full_name) }
    password { Faker::Internet.password }
    image { Faker::Avatar.image(full_name.split(' ').join('').underscore, '200x200', 'jpg') }
  end
end
