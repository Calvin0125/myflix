class Review < ActiveRecord::Base
  default_scope { order(created_at: :desc) }
  belongs_to :user, optional: true
  belongs_to :video, optional: true

  validates_presence_of :rating, :body
end