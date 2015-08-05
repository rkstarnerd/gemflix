class RelationshipsController < ApplicationController
  before_filter :require_user, only: [:index, :destroy, :create]
  def index
    @relationships = current_user.following_relationships
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if current_user == relationship.follower
    redirect_to people_path
  end

  def create
    leader = User.find(params[:leader_id])
    Relationship.create(leader_id: params[:leader_id], follower: current_user) unless current_user.follows? (leader)
    redirect_to people_path
  end

  private

  def relationship_params
    params.require(:relationship).permit(:leader_id)    
  end
end