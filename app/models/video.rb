class Video < ActiveRecord::Base
  belongs_to :category, optional: true
  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    Video.where('title ILIKE ?', "%#{search_term}%")
  end
end