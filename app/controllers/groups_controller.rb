class GroupsController < ApplicationController
  def index
    @groups = Group.includes(users: :user_profile).active.order(:id)
  end
end
