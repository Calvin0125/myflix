class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :title, :description, :large_cover_url, :small_cover_url
      t.timestamps
    end
  end
end
