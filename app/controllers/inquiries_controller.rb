# frozen_string_literal: true
class InquiriesController < ApplicationController
  def create
    @inquiry = Inquiry.new(permitted_params) { |i| i.user = current_user }
    assign_request_info(@inquiry)

    Mailer::Inquiry.create(@inquiry).deliver_now if @inquiry.save
  end

  private

  def assign_request_info(inquiry)
    inquiry.referer = request.headers['HTTP_REFERER']
    inquiry.user_agent = request.headers['HTTP_USER_AGENT']
    inquiry.session_id = session.id
    inquiry
  end

  def permitted_params
    params.require(:inquiry).permit(:body)
  end
end
