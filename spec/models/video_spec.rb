require 'spec_helper'

describe Video do
  it { should have_many(:categories) }

  it { should validate_presence_of(:title) }

  it { should validate_presence_of(:description) }

  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      sherlock = Video.create(title: "Sherlock", description: "sleuth")
      breaking_bad = Video.create(title: "Breaking Bad", description: "teacher turned drug dealer")
      expect(Video.search_by_title("hello")).to eq([])
    end

    it "returns an array of one video for an exact match" do
      sherlock = Video.create(title: "Sherlock", description: "sleuth")
      breaking_bad = Video.create(title: "Breaking Bad", description: "teacher turned drug dealer")
      expect(Video.search_by_title("Sherlock")).to eq([sherlock])
    end

    it "returns an array of one video for a partial match" do
      sherlock = Video.create(title: "Sherlock", description: "sleuth")
      breaking_bad = Video.create(title: "Breaking Bad", description: "teacher turned drug dealer")
      expect(Video.search_by_title("lock")).to eq([sherlock])
    end

    it "returns an array of all matches ordered by created_at" do
      sherlock = Video.create(title: "Sherlock Bad", description: "sleuth", created_at: 1.day.ago)
      breaking_bad = Video.create(title: "Breaking Bad", description: "teacher turned drug dealer")
      expect(Video.search_by_title("bad")).to eq([breaking_bad, sherlock])
    end

    it "returns an empty array for a search with an empty string" do
      sherlock = Video.create(title: "Sherlock Bad", description: "sleuth", created_at: 1.day.ago)
      breaking_bad = Video.create(title: "Breaking Bad", description: "teacher turned drug dealer")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end