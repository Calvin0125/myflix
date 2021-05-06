class User < ActiveRecord::Base
  # has_secure_password already adds validation for presence of password
  has_secure_password
  has_many :reviews
  has_many :queue_items
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id

  validates_presence_of :email, :full_name
  validates_uniqueness_of :email

  def already_following?(user)
    Relationship.where(follower: self, leader: user).count > 0
  end

  def set_token
    self.token = SecureRandom.urlsafe_base64
    save
  end

  def remove_token
    self.token = nil
    save
  end

  def to_param
    self.token ? self.token : self.id.to_s
  end
end