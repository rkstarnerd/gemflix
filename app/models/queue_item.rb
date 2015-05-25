class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :title, to: :video, prefix: :video

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    if review
      review.rating
    else
      nil
    end
  end

  def category_name
    category_names = video.categories.map { |category| category.name }
    category_names.join(" ")
  end

  def category
    video.categories.first
  end
end