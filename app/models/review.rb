class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates_presence_of :description
  validates_presence_of :rating

  def self.average_rating(video)
    ratings = video.reviews.all.reload.map {|review| review.rating}
    if video.reviews.count == 0
      return "Be the first to review this video!"
    else
      (ratings.inject(:+).to_f)/(video.reviews.count)
    end
  end
end