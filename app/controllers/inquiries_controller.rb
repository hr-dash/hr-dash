class InquiriesController < ApplicationController
  def create
    @inquiry = Inquiry.new(permitted_params) do |i|
      i.user = current_user
      i.referer = request.headers['HTTP_REFERER']
      i.user_agent = request.headers['HTTP_USER_AGENT']
      i.session_id = session.id
    end

    if @inquiry.save
      Mailer::Inquiry.create(@inquiry).deliver_now
    end
  end

  private

  def permitted_params
    params.require(:inquiry).permit(:body)
  end
end
