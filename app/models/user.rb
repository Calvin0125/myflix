class User < ActiveRecord::Base
  # has_secure_password already adds validation for presence of password
  has_secure_password
  has_many :reviews
  has_many :queue_items
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id
  
  validates_presence_of :email, :full_name
  validates_uniqueness_of :email
end