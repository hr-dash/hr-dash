class TagsController < ApplicationController
  def index
    @tags = Tag.fixed
  end
end
