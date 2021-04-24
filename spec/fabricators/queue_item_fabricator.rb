require 'faker'

Fabricator(:queue_item) do
  position { 1 }
  user_id { 1 }
  video_id { 1 }
end