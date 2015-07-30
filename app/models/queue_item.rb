class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :title, to: :video, prefix: :video

  validates_numericality_of :position, {only_integer: true}

  def rating
    review
    review.rating if review
  end

  def rating=(new_rating)
    review
    update(review, new_rating)
  end

  def category_name
    category_names = video.categories.map { |category| category.name }
    category_names.join(" ")
  end

  def category
    video.categories.first
  end

  private

  def review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end

  def create_review(new_rating)
    review = Review.new(user: user, video: video, rating: new_rating)
    review.save(validate: false)
  end

  def update(review, new_rating)
    if review
      review.update_column(:rating, new_rating)
    else
      create_review(new_rating)
    end
  end
end