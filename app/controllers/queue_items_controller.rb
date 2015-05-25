class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    user = current_user
    video = Video.find(params[:video_id])
    QueueItem.create(video: video, user: user, position: current_user.queue_items.count + 1 ) unless current_user.queue_items.map(&:video).include?(video)
    redirect_to my_queue_path
  end
end