class GroupsController < ApplicationController
  def index
    @groups = Group.includes(:users).active.order(:id)
  end
end
