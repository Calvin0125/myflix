require 'rails_helper.rb'

describe QueueItem do 
  describe "associations" do
    it { should belong_to(:user).optional }
    it { should belong_to(:video).optional }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:position).scoped_to(:user_id) }
    it { should validate_uniqueness_of(:video_id).scoped_to(:user_id) }
  end

  describe "::next_position" do
    it "should return the largest position for the given user + 1" do
      user = Fabricate(:user)
      3.times { |n| Fabricate(:queue_item, position: n + 1, user_id: user.id, video_id: n) }
      expect(QueueItem.next_position(user)).to eq(4)
    end

    it "should return 1 if there are no queue items for the given user" do
      user = Fabricate(:user)
      expect(QueueItem.next_position(user)).to eq(1)
    end
  end
end