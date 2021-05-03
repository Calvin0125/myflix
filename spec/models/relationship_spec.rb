require 'rails_helper.rb'

describe Relationship do
  describe "associations" do
    it { should belong_to(:follower).class_name("User") }
    it { should belong_to(:leader).class_name("User") }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:leader_id).scoped_to(:follower_id) }
    it { should validate_uniqueness_of(:follower_id).scoped_to(:leader_id) }
    it "validates that leader_id and follower_id cannot be the same" do
      user = Fabricate(:user)
      relationship = Relationship.new(leader_id: user.id, follower_id: user.id)
      relationship.save
      expect(relationship.valid?).to eq(false)
      expect(relationship.errors.full_messages).to eq(["Leader and follower cannot be the same user."])
    end
  end
end