class GroupsController < ApplicationController
  def index
    @groups = Group.includes(:users).all.order(:id)
  end
end
