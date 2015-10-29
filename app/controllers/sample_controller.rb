class SampleController < ApplicationController
  def index
  end

  def login
    render :login, layout: false
  end
end
