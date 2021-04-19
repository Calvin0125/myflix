class ReviewsController < ApplicationController
  before_action :require_login

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = "Your review was added."
    else
      flash[:danger] = "Your review was not added, please select a rating and fill in the textbox."
    end
    redirect_to video_path(@review.video_id)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body, :user_id, :video_id)
  end
end