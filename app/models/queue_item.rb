class QueueItem < ActiveRecord::Base
  belongs_to :user, optional: true
  belongs_to :video, optional: true

  validates_uniqueness_of :video_id, scope: :user_id
  validates_uniqueness_of :position, scope: :user_id

  def self.next_position(user)
    last_queue_item = user.queue_items.order(position: :desc).limit(1).first
    last_queue_item.nil? ? 1 : last_queue_item.position + 1
  end
end