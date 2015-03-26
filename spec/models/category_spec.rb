require 'spec_helper'

describe Category do
    it { should have_many(:videos) }

  describe "#recent_videos" do
    it "returns the videos in the reverse order by created at" do
      drama = Category.create(id: 1, name: "drama")
      the_following    = Video.create(id: 1, title: "The Following", created_at: 1.day.ago)
      sherlock         = Video.create(id: 2, title: "Sherlock")
  
      # breaking_bad     = Video.create(id: 3, title: "Breaking Bad")
      # the_walking_dead = Video.create(id: 4, title: "The Walking Dead")
      # suits            = Video.create(id: 5, title: "Suits")
      # empire           = Video.create(id: 6, title: "Empire")
      Video.all.each do |video| 
        VideoCategory.create(video_id: video.id, category_id: 1)
      end
      expect(drama.videos).to eq([sherlock, the_following])
    end

    it "returns all of the videos if there are less than 6 videos"
    it "returns 6 videos if there are more than 6 videos"
    it "returns the most recent 6 videos"
    it "returns an empty array if the category does not have any videos"
  end
end