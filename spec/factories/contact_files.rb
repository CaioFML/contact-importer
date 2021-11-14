FactoryBot.define do
  factory :contact_file do
    user
    status { :on_hold }
  end
end
