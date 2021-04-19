require 'faker'

Fabricator(:review) do
  rating { rand(1..5) }
  body { Faker::Lorem.words(number: 25) }
end