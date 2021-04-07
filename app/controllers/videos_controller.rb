class VideosController < ApplicationController
  def index
    @categories = Category.all
    render 'ui/home'
  end

  def show
    @video = Video.find(params[:id])
    render 'ui/video'
  end
end