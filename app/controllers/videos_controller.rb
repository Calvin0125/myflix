class VideosController < ApplicationController
  before_action :require_login
  
  def index
    @categories = Category.all
    render :home
  end

  def show
    @video = Video.find(params[:id])
    @review = Review.new
    render :video
  end

  def search
    @videos = Video.search_by_title(params["search-term"])
    render :search
  end
end