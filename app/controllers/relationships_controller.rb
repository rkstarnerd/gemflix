class RelationshipsController < ApplicationController
  before_filter :require_user, only: [:index, :destroy]
  def index
    @relationships = current_user.following_relationships
  end

  def destroy
    redirect_to people_path
    # relationship = current_user.following_relationships.find
    # relationship.destroy
  end
end