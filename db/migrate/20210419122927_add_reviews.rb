class AddReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :body
      t.integer :user_id
      t.integer :video_id
      t.timestamps
    end
  end
end
