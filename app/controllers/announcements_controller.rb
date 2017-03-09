# frozen_string_literal: true
class AnnouncementsController < ApplicationController
  def index
    @announcements = Announcement.published.page params[:page]
  end
end
