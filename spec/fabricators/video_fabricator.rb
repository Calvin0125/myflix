require 'faker'

Fabricator(:video) do
  title { Faker::Lorem.words(2).join(" ") }
  description { Faker::Lorem.words(10).join(" ") }
end