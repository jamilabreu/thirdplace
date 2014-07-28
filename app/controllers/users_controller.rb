class UsersController < ApplicationController
  def index
    @users = User.select('users.*, COUNT(DISTINCT communities.id) AS community_count')
    @users = @users.preload(:communities).joins(:communities).where(communities: { id: current_user.community_ids })
    @users = @users.where.not(id: current_user)
    @users = @users.where("users.name <> ''")
    @users = @users.group('users.id')
    @users = @users.having('COUNT(DISTINCT communities.id) > 1')
    @users = @users.order('community_count DESC')
  end
end