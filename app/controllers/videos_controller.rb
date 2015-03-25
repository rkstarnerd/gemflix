class VideosController < ApplicationController
  before_action :set_categories, only: [:index, :search]
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @videos = Video.search_by_title(params[:search_term])
  end

  private
  def set_categories
    @categories = Category.all
  end
end