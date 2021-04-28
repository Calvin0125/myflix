class QueueItem < ActiveRecord::Base
  belongs_to :user, optional: true
  belongs_to :video, optional: true

  validates_uniqueness_of :video_id, scope: :user_id
  validates_uniqueness_of :position, scope: :user_id
  validates_numericality_of :position, only_integer: true

  def review
    self.user.reviews.where(video_id: self.video_id).first
  end

  def self.next_position(user)
    user.queue_items.count + 1
  end

  def self.delete_and_update_positions(id, current_user)
    item_to_delete = QueueItem.find(id)
    missing_position = item_to_delete.position
    if item_to_delete.user == current_user
      QueueItem.destroy(item_to_delete.id)
      update_positions_after_deletion(current_user.id, missing_position)
    end
  end

  def self.reorder_positions(user, positions_hash)
    remove_positions_with_no_change(positions_hash)
    raise StandardError.new if user_attempts_multiple_position_changes(positions_hash)
    current_position, new_position = positions_hash.keys[0], positions_hash.values[0]
    new_position = ensure_new_position_is_in_range(new_position, user)
    QueueItem.transaction do
      update_position(current_position, new_position, user)
    end
  end

  private

  def self.ensure_new_position_is_in_range(new_position, user)
    if new_position.to_i > user.queue_items.count
      user.queue_items.count.to_s
    elsif new_position.to_i < 1
      "1"
    else
      new_position
    end
  end

  def self.remove_positions_with_no_change(positions_hash)
    positions_hash.delete_if { |current_position, new_position| current_position == new_position }
  end

  def self.user_attempts_multiple_position_changes(positions_hash)
    positions_hash.values.length > 1
  end

  def self.update_position(current_position, new_position, user)
    item_to_update = user.queue_items.where(position: current_position).first
    item_to_update.update(position: 5000)
    if current_position > new_position
      move_intermediate_positions_up(user, current_position, new_position)
    elsif current_position < new_position
      move_intermediate_positions_down(user, current_position, new_position)
    end
    item_to_update.position = new_position
    item_to_update.save!
  end

  def self.move_intermediate_positions_up(user, current_position, new_position)
    user.queue_items.where("position < #{current_position} AND position >= #{new_position}")
                    .order(position: :desc).each do |item|
      item.position += 1
      item.save!
    end
  end

  def self.move_intermediate_positions_down(user, current_position, new_position)
    user.queue_items.where("position > #{current_position} AND position <= #{new_position}").each do |item|
      item.position -= 1
      item.save!
    end
  end

  def self.update_positions_after_deletion(user_id, missing_position)
    items_to_update = QueueItem.where("user_id = '#{user_id}' AND position > '#{missing_position}'")
    items_to_update.each do |item|
      item.position -= 1
      item.save
    end
  end
end