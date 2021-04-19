class Review < ActiveRecord::Base
  belongs_to :user, optional: true
  belongs_to :video, optional: true

  validates_presence_of :rating, :body
end