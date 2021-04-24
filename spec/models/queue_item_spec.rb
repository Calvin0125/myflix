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

  describe "::delete_and_update_positions" do
    it "should remove queue item with specified id, and update positions for that user" do
      user = Fabricate(:user)
      queue_items = []
      3.times do |n|
        queue_items << Fabricate(:queue_item, position: n + 1, user_id: user.id, video_id: n)
      end
      queue_item1, queue_item2, queue_item3 = queue_items
      id_to_delete = queue_item2.id
      QueueItem.delete_and_update_positions(id_to_delete)
      expect(user.queue_items).to eq([queue_item1, queue_item3])
      expect(user.queue_items.last.position).to eq(2)
    end
  end
end