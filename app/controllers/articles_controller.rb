# frozen_string_literal: true
class ArticlesController < ApplicationController
  before_action :assign_placeholders, only: [:new, :create, :edit, :update]
  before_action :assign_saved_article, only: [:edit, :update]

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
      assign_relational_params(article)
    end

    save_and_render(:new)
  end

  def edit; end

  def update
    @article.assign_attributes(permitted_params)
    assign_relational_params(@article)
    save_and_render(:edit)
  end

  def destroy
    @article = current_user.articles.find(params[:id])

    if @article.destroy
      flash[:notice] = '記事を削除しました'
      redirect_to :articles
    else
      flash_errors(@article)
      render @article
    end
  end

  private

  def forbidden_other_user(article)
    raise(Forbidden, 'can not see wip articles of other users') unless article.browseable?(current_user)
  end

  def save_and_render(action)
    if @article.save
      redirect_to @article
    else
      flash_errors(@article)
      render action
    end
  end

  def assign_saved_article
    @article = current_user.articles.includes(article_tags: :tag).find(params[:id])
  end

  def permitted_params
    params.require(:article).permit(
      :title,
      :body,
    )
  end

  def flash_errors(article)
    flash.now[:error] = article.errors.full_messages
  end

  def assign_relational_params(article)
    article.ship unless params[:wip]
    article.tags = article_tags
  end

  def article_tags
    tags = params[:article][:article_tags].try!(:split, ',').try!(:map) do |name|
      tag = Tag.find_or_initialize_by_name_ignore_case(name.strip)
      tag.save ? tag : nil
    end.try!(:compact)

    tags || []
  end

  def assign_placeholders
    @placeholders = HelpText.placeholders(:article)
  end
end
