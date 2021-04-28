require 'rails_helper.rb'

describe Review do
  describe "associations" do
    it { should belong_to(:user).optional }
    it { should belong_to(:video).optional }
  end

  describe "validations" do
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:body) }
    it { should validate_uniqueness_of(:video_id).scoped_to(:user_id) }
  end

  describe "order" do
    it "orders by created_at descending" do
      5.times { |n| Fabricate(:review, video_id: n ) }
      expect(Review.all).to eq(Review.all.order(created_at: :desc))
    end
  end

  describe "::update_or_create_reviews" do
    it "should update existing reviews" do
      user = Fabricate(:user)
      video1, video2 = Fabricate(:video), Fabricate(:video)
      review1 = Fabricate(:review, video_id: video1.id, rating: 3, user_id: user.id)
      review2 = Fabricate(:review, video_id: video2.id, rating: 3, user_id: user.id)
      Review.update_or_create_reviews(user, [{id: review1.id.to_s, video_id: video1.id.to_s, rating: "2"},
                                             {id: review2.id.to_s, video_id: video2.id.to_s, rating: "4"}])
      expect(Review.find(review1.id).rating).to eq(2)                                       
      expect(Review.find(review2.id).rating).to eq(4)
    end

    it "should create a new review if one doesn't already exist" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Review.update_or_create_reviews(user, [{id: '', video_id: video.id.to_s, rating: "5"}])
      expect(user.reviews.count).to eq(1)
      expect(user.reviews.first.rating).to eq(5)
    end

    it "should not create a review if user leaves the select box blank" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Review.update_or_create_reviews(user, [{id: '', video_id: video.id.to_s, rating: ''}])
      expect(user.reviews.count).to eq(0)
    end

    it "should not update a review that belongs to another user" do
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, video_id: video.id, user_id: user2.id, rating: 2)
      Review.update_or_create_reviews(user1, [{id: review.id.to_s, video_id: video.id.to_s, rating: 3}])
      expect(user2.reviews.first.rating).to eq(2)
    end
  end
end