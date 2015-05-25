class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  def video_title
    video.title
  end

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    if review
      review.rating
    else
      nil
    end
  end
end