FactoryBot.define do
  factory :contact do
    name { Faker::Name.name.gsub(/\W/, "") }
    date_of_birth { Time.zone.today }
    phone { "(+57) 320-432-05-09" }
    email { Faker::Internet.email }
    address { Faker::Address.street_name }
    credit_card { "4111111111111111" }
    user
  end
end
