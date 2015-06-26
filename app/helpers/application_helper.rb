module ApplicationHelper
  def options_for_video_reviews
    options_for_select([5, 4, 3, 2, 1].map { |num| [pluralize(num, "Star"), num] })
  end
end
