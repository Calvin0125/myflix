class QueueItem < ActiveRecord::Base
  belongs_to :user, optional: true
  belongs_to :video, optional: true

  validates_uniqueness_of :video_id, scope: :user_id
  validates_uniqueness_of :position, scope: :user_id

  def self.next_position(user)
    last_queue_item = user.queue_items.order(position: :desc).limit(1).first
    last_queue_item.nil? ? 1 : last_queue_item.position + 1
  end

  def self.delete_and_update_positions(id)
    item_to_delete = QueueItem.find(id)
    missing_position = item_to_delete.position
    user = item_to_delete.user
    QueueItem.destroy(item_to_delete.id)
    update_positions(user.id, missing_position)
  end

  private

  def self.update_positions(user_id, missing_position)
    items_to_update = QueueItem.where("user_id = '#{user_id}' AND position > '#{missing_position}'")
    items_to_update.each do |item|
      item.position -= 1
      item.save
    end
  end
end