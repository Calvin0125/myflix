class RelationshipsController < ApplicationController
  before_action :require_login

  def index
    @relationships = helpers.current_user.following_relationships
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if relationship.follower_id == helpers.current_user.id
    flash[:success] = "You have unfollowed #{relationship.leader.full_name}."
    redirect_back fallback_location: people_path
  end

  def create
    leading_user = User.find(params[:leader_id])
    relationship = Relationship.new(follower: helpers.current_user, leader: leading_user)

    if relationship.save
      flash[:success] = "You are following #{leading_user.full_name}"
    else
      flash[:danger] = "Your request to follow #{leading_user.full_name} could not be completed."
    end

    redirect_to user_path(leading_user)
  end
end