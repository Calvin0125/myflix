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

  describe " =>:next_position" do
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

  describe " =>:delete_and_update_positions" do
    it "should remove queue item with specified id, and update positions for that user" do
      user = Fabricate(:user)
      queue_items = []
      3.times do |n|
        queue_items << Fabricate(:queue_item, position: n + 1, user_id: user.id, video_id: n)
      end
      queue_item1, queue_item2, queue_item3 = queue_items
      id_to_delete = queue_item2.id
      QueueItem.delete_and_update_positions(id_to_delete, user)
      expect(user.queue_items).to eq([queue_item1, queue_item3])
      expect(user.queue_items.last.position).to eq(2)
    end

    it "should not delete an item that doesn't belong to current user" do
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user_id: user1.id)
      QueueItem.delete_and_update_positions(queue_item.id, user2)
      expect(QueueItem.count).to eq(1)
    end
  end

  #expected behavior:
    #if a position is changed to a larger number, the positions less than or equal to the new number and 
    # greater than the old number are reduced by 1 so there is no gap in positions or duplicate positions
    #if a position is changed to a smaller number, the positions greater or equal to the new number and less
    # than the old number are increased by 1 so there is no gap in positions or duplicate positions
    #if multiple changes are made, the changes are made starting with the lowest original position, and
    # any positions that have already been changed are 'locked' so they will not be changed again

  describe "::reorder_positions" do
    it "reorders correctly with 1 change" do
      user = Fabricate(:user)
      old_items = {}
      5.times { |n| old_items[n + 1] = Fabricate(:queue_item, position: n + 1, user_id: user.id, video_id: n + 1) }
      # change position 3 => 1
      positions_hash = { "1" => "1", "2" => "2", "3" => "1", "4" => "4", "5" => "5"}
      QueueItem.reorder_positions(user, positions_hash)
      expect(user.queue_items.where(position: 1)).to eq([old_items[3]])
      expect(user.queue_items.where(position: 2)).to eq([old_items[1]])
      expect(user.queue_items.where(position: 3)).to eq([old_items[2]])
      expect(user.queue_items.where(position: 4)).to eq([old_items[4]])
      expect(user.queue_items.where(position: 5)).to eq([old_items[5]])
    end

    it "reduces an arbitrarily high position to the last position in the queue" do
      user = Fabricate(:user)
      old_items = {}
      3.times { |n| old_items[n + 1] = Fabricate(:queue_item, position: n + 1, user_id: user.id, video_id: n + 1) }
      positions_hash = { "1" => "1", "2" => "42", "3" => "3" }
      QueueItem.reorder_positions(user, positions_hash)
      expect(user.queue_items.where(position: 1)).to eq([old_items[1]])
      expect(user.queue_items.where(position: 2)).to eq([old_items[3]])
      expect(user.queue_items.where(position: 3)).to eq([old_items[2]])
    end

    it "increases an arbitrarily low position to 1" do
      user = Fabricate(:user)
      old_items = {}
      3.times { |n| old_items[n + 1] = Fabricate(:queue_item, position: n + 1, user_id: user.id, video_id: n + 1) }
      positions_hash = { "1" => "1", "2" => "2", "3" => "-42" }
      QueueItem.reorder_positions(user, positions_hash)
      expect(user.queue_items.where(position: 1)).to eq([old_items[3]])
      expect(user.queue_items.where(position: 2)).to eq([old_items[1]])
      expect(user.queue_items.where(position: 3)).to eq([old_items[2]])
    end

    it "throws an error if the user changes more than 1 position at a time" do
      user = Fabricate(:user)
      old_items = {}
      6.times { |n| old_items[n + 1] = Fabricate(:queue_item, position: n + 1, user_id: user.id, video_id: n + 1) }
      positions_hash = { "1" => "1", "2" => "4", "3" => "3", "4" => "4", "5" => "6", "6" => "6"}
      expect { QueueItem.reorder_positions(user, positions_hash) }.to raise_error(StandardError)
    end
  end
end