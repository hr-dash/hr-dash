class GroupsController < ApplicationController
  def index
    @groups = Group.all.order(:id)
  end
end
