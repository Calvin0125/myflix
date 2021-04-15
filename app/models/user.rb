class User < ActiveRecord::Base
  # has_secure_password already adds validation for presence of password
  has_secure_password

  validates_presence_of :email, :full_name
  validates_uniqueness_of :email
end