require 'faker'

Fabricator(:review) do
  rating { rand(1..5) }
  body { Faker::Lorem.words(number: 25).join(" ") }
  video_id { 1 }
  user_id { 1 }
end