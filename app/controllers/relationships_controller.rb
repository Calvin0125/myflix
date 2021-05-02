class RelationshipsController < ApplicationController
  before_action :require_login

  def index
    @relationships = helpers.current_user.following_relationships
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if relationship.follower_id == helpers.current_user.id
    redirect_to people_path
  end
end