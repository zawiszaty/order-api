FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password_digest { 'test123456' }
    password { 'test123456' }
  end
end
