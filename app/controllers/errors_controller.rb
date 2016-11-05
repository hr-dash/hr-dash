class ErrorsController < ActionController::Base
  layout 'error'

  rescue_from StandardError, with: :render_internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :render_not_found

  def render_not_found(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render template: 'errors/404', status: 404
  end

  def render_internal_server_error(exception = nil)
    if exception
      Mailer::Error.create(exception, current_user, request).deliver_now
      logger.info "Rendering 500 with exception: #{exception.message}"
    end
    render template: 'errors/500', status: 500
  end

  def show
    fail env['action_dispatch.exception']
  end
end
