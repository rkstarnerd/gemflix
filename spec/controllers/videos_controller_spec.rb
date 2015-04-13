require 'spec_helper'

describe VideosController do
  describe "GET index" do
    it { should use_before_action(:set_categories) }
    it { should use_before_action(:require_user)   }

    it "sets the @videos variable" do
      sherlock = Video.create(title: "Sherlock",   description: "sleuth")
      matrix   = Video.create(title: "The Matrix", description: "the one")
      get :index
      expect(assigns(:videos)).to eq([sherlock, matrix])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end