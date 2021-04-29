class Review < ActiveRecord::Base
  default_scope { order(created_at: :desc) }
  belongs_to :user, optional: true
  belongs_to :video, optional: true

  validates_presence_of :rating, :body
  validates_uniqueness_of :video_id, scope: :user_id

  def self.update_or_create_reviews(user, reviews_array)
    reviews_array.each do |review|
      if review[:id] != ''
        review_to_update = find(review[:id].to_i)
        if review_to_update.user == user && review[:rating].to_i != 0
          review_to_update.rating = review[:rating].to_i 
          review_to_update.body = "Rating only" if !review_to_update.body
          review_to_update.save
        end
      elsif review[:rating] != ''
        new_review = new(rating: review[:rating].to_i, video_id: review[:video_id].to_i, user: user)
        new_review.body = "Rating only"
        new_review.save
      end
    end
  end
end