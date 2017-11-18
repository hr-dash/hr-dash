# frozen_string_literal: true

describe ErrorsController, type: :request do
  after { ActionMailer::Base.deliveries.clear }

  describe '404' do
    context 'ActionController::RoutingError' do
      before { get '/page_not_found' }

      it { expect(response).to have_http_status :not_found }
      it { expect(response).to render_template('errors/404') }
      it { expect(ActionMailer::Base.deliveries.size).to eq(0) }
    end

    context 'ActiveRecord::RecordNotFound' do
      before do
        login
        delete monthly_report_comment_path(1)
      end

      it { expect(response).to have_http_status :not_found }
      it { expect(response).to render_template('errors/404') }
      it { expect(ActionMailer::Base.deliveries.size).to eq(0) }
    end
  end

  describe '500' do
    context 'Other Errors' do
      before do
        login
        post monthly_report_comments_path
      end

      it { expect(response).to have_http_status :error }
      it { expect(response).to render_template('errors/500') }
      it { expect(ActionMailer::Base.deliveries.size).to eq(1) }
    end
  end
end
