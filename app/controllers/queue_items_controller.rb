class QueueItemsController < ApplicationController
  before_action :require_login

  def index
    @queue_items = helpers.current_user.queue_items.order(:position)
  end
end