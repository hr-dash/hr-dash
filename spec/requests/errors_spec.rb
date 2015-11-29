describe ErrorsController, type: :request do
  describe '404' do
    context 'ActionController::RoutingError' do
      before { get '/page_not_found' }

      it { expect(response).to have_http_status :not_found }
      it { expect(response).to render_template('errors/404') }
    end

    context 'ActiveRecord::RecordNotFound' do
      before do
        login
        delete monthly_report_comment_path(1)
      end

      it { expect(response).to have_http_status :not_found }
      it { expect(response).to render_template('errors/404') }
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
    end
  end
end
