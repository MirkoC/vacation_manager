FactoryGirl.define do
  factory :worker do
    full_name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    image { Faker::Avatar.image(full_name.split(' ').join('').underscore, '200x200', 'jpg') }
  end
end
