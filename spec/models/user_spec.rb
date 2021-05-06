require 'rails_helper.rb'

describe User do
  describe "security" do
    it { should have_secure_password }
  end

  describe "associations" do
    it { should have_many(:reviews) }
    it { should have_many(:queue_items) }
    it { should have_many(:following_relationships).class_name('Relationship').with_foreign_key('follower_id') }
    it { should have_many(:leading_relationships).class_name('Relationship').with_foreign_key('leader_id') }
  end

  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :full_name }
    it { should validate_presence_of :password }
    it { should validate_uniqueness_of :email }
  end

  describe "#set_token" do
    it "should set a random token for the user" do
      user = Fabricate(:user)
      user.set_token
      expect(User.first.token).not_to be_blank
    end
  end

  describe "#remove_token" do
    it "should remove the token for the user" do
      user = Fabricate(:user)
      user.set_token
      user.remove_token
      expect(User.first.token).to be_blank
    end
  end
end