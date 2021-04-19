require 'rails_helper.rb'

describe Review do
  describe "associations" do
    it { should belong_to(:user).optional }
    it { should belong_to(:video).optional }
  end

  describe "validations" do
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:body) }
  end

  describe "order" do
    it "orders by created_at descending" do
      5.times { Fabricate(:review) }
      expect(Review.all).to eq(Review.all.order(created_at: :desc))
    end
  end
end