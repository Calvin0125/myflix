class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :leader, class_name: "User"

  validates_uniqueness_of :follower_id, scope: :leader_id
  validates_uniqueness_of :leader_id, scope: :follower_id
  validate :leader_not_equal_to_follower

  private

  def leader_not_equal_to_follower
    if self.leader_id == self.follower_id
      @errors.add(:base, "Leader and follower cannot be the same user.")
    end
  end
end