require 'faker'

Fabricator(:user) do
  full_name { Faker::Lorem.words(2).join(" ") }
  password { Faker::Lorem.words(1)[0] }
  email { Faker::Internet.email }
end