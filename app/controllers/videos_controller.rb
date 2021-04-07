class VideosController < ApplicationController
  def index
    @videos = Video.all
    render 'ui/home'
  end

  def show
    @video = Video.find(params[:id])
    render 'ui/video'
  end
end