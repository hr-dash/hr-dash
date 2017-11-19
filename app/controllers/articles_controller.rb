# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :assign_placeholders, only: %i[new create edit update]
  before_action :assign_article, only: %i[edit update]

  def index
    references = [:user, { article_tags: :tag }]
    @articles = Article.includes(references).shipped.order(shipped_at: :desc).page params[:page]
  end

  def user
    @article_user = User.find(params[:user_id])
    @articles = @article_user.articles.includes(article_tags: :tag).shipped.order(shipped_at: :desc).page params[:page]
  end

  def drafts
    @articles = current_user.articles.includes(article_tags: :tag).wip.order(created_at: :desc).page params[:page]
  end

  def show
    @article = Article.includes(comments: :user).find(params[:id])
    raise(Forbidden, 'can not see wip articles of other users') unless @article.browseable?(current_user)
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = Article.new(permitted_params) do |article|
      article.user = current_user
      article.assign_relational_params(params[:wip], article_tags)
    end

    if @article.save
      redirect_to @article
    else
      flash_errors
      render :new
    end
  end

  def edit; end

  def update
    @article.assign_attributes(permitted_params)
    @article.assign_relational_params(params[:wip], article_tags)

    if @article.save
      redirect_to @article
    else
      flash_errors
      render :edit
    end
  end

  def destroy
    @article = current_user.articles.find(params[:id])

    if @article.destroy
      flash[:notice] = 'ノートを削除しました'
      redirect_to :articles
    else
      flash_errors
      render @article
    end
  end

  private

  def assign_article
    @article = current_user.articles.includes(article_tags: :tag).find(params[:id])
  end

  def permitted_params
    params.require(:article).permit(
      :title,
      :body,
    )
  end

  def flash_errors
    flash.now[:error] = @article.errors.full_messages
  end

  # TODO: https://github.com/hr-dash/hr-dash/pull/481/files#diff-ddd1a6250ecb975d0c309f9af262ff5eR37 のように置き換える
  def article_tags
    tags = params[:article][:article_tags]&.split(',')&.map do |name|
      tag = Tag.find_or_initialize_by_name_ignore_case(name.strip)
      tag.save ? tag : nil
    end&.compact

    tags || []
  end

  def assign_placeholders
    @placeholders = HelpText.placeholders(:article)
  end
end
