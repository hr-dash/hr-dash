# frozen_string_literal: true
class ArticlesController < ApplicationController
  def new
    @article = current_user.articles.build
  end
end
