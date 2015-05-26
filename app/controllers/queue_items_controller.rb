class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    user = current_user
    video = Video.find(params[:video_id])
    queue_video(video, user)
    redirect_to my_queue_path
  end

  def destroy
    user = current_user
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    redirect_to my_queue_path
  end

  private

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def already_queued?(video)
    current_user.queue_items.map(&:video).include?(video)
  end

  def queue_video(video, user)
    QueueItem.create(video: video, user: user, position: new_queue_item_position) unless already_queued?(video)
  end
end