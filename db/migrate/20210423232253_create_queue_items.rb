class CreateQueueItems < ActiveRecord::Migration[6.1]
  def change
    create_table :queue_items do |t|
      t.integer :position, :video_id, :user_id
      t.timestamps
    end
  end
end
