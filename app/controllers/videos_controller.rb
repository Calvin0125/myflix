class VideosController < ApplicationController
  before_action :require_login
  
  def index
    @categories = Category.all
    render 'ui/home'
  end

  def show
    @video = Video.find(params[:id])
    render 'ui/video'
  end

  def search
    @videos = Video.search_by_title(params["search-term"])
    render 'ui/search'
  end
end