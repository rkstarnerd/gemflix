require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name)}

  let(:drama) { Category.create(id: 1, name: "drama") }

  describe "#recent_videos" do
    it "returns the videos in the reverse order by created at" do
      the_following = Video.create(id: 1, title: "The Following", description: "psychos", created_at: 1.day.ago)
      sherlock = Video.create(id: 2, title: "Sherlock", description: "detective")
      assign_category_to_videos (drama)
      expect(drama.recent_videos).to eq([sherlock, the_following])
    end

    it "returns all of the videos if there are less than 6 videos" do
      2.times { create_video }
      assign_category_to_videos(drama)
      expect(drama.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if there are more than 6 videos" do
      7.times { create_video }
      assign_category_to_videos(drama)
      expect(drama.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      6.times { create_video }
      movies = assign_category_to_videos(drama)
      expect(drama.recent_videos).to eq(movies.reverse)
    end

    it "returns an empty array if the category does not have any videos" do
      expect(drama.recent_videos).to eq([])
    end
  end
end
