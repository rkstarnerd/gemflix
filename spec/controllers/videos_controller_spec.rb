require 'spec_helper'

describe VideosController do

  let(:sherlock) { Video.create(title: "Sherlock",   description: "sleuth") }
  let(:matrix) { Video.create(title: "The Matrix", description: "the one") }

  describe "GET show" do
    it { should use_before_action(:require_user)   }

    it "sets the @video variable" do
    end
    it "renders the show template" do
    end
  end

  describe "GET search" do
    it { should use_before_action(:set_categories) }
    it { should use_before_action(:require_user)   }

    it "sets the @videos variable" do
    end
    it "renders the search template" do
    end
  end
end