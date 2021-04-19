class Video < ActiveRecord::Base
  belongs_to :category, optional: true
  has_many :reviews
  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    Video.where('title ILIKE ?', "%#{search_term}%")
  end

  def average_rating
    return nil if self.reviews.count == 0
    rating_sum = self.reviews.map(&:rating).reduce(:+)
    average = rating_sum.to_f / self.reviews.count.to_f
    sprintf('%.1f', average.round(1))
  end
end