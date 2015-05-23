class ReviewsController < ApplicationController
  before_action :require_user

  def new
    @review = Review.new
  end

  def create
    @video  = Video.find(params[:video_id])
    @reviews = @video.reviews.all.reload
    review = @video.reviews.build(params.require(:review).permit(:description, :rating).merge!(user: current_user))

    if review.save
      redirect_to @video
    else
      flash[:error] = "Please include a review description."
      render 'videos/show'
    end
  end
end