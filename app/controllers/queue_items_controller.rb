class QueueItemsController < ApplicationController
  before_action :require_login

  def index
    @queue_items = helpers.current_user.queue_items.order(:position)
  end

  def create
    @queue_item = QueueItem.new(queue_item_params)
    if @queue_item.save
      flash[:success] = "This video has been added to your queue."
    else
      flash[:warning] = "This video is already in your queue."
    end
    redirect_to video_path(params[:queue_item][:video_id])
  end

  private

  def queue_item_params
    params.require(:queue_item).permit(:position, :user_id, :video_id)
  end
end