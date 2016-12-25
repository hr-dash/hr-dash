class AnnouncementsController < ApplicationController
  def index
    @announcements = Announcement.published.ransack.result.page params[:page]
  end
end
