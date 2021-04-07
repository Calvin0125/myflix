class AddCategoryIdToVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :category_id, :integer
  end
end
