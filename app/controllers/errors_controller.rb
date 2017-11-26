# frozen_string_literal: true

class ErrorsController < ActionController::Base
  layout 'error'

  rescue_from StandardError, with: :render_internal_server_error
  rescue_from ActionController::NotImplemented, with: :render_not_implemented
  rescue_from ApplicationController::Forbidden, with: :render_forbidden
  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::MethodNotAllowed, with: :render_method_not_allowed
  rescue_from ActiveRecord::StaleObjectError, with: :render_conflict
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotSaved, with: :render_unprocessable_entity
  rescue_from ActionController::InvalidAuthenticityToken, with: :render_unprocessable_entity

  def render_forbidden(exception = nil)
    log_error(exception)
    render template: 'errors/403', status: 403
  end

  def render_not_found(exception = nil)
    log_error(exception)
    render template: 'errors/404', status: 404
  end

  def render_method_not_allowed(exception = nil)
    log_error(exception)
    render template: 'errors/405', status: 405
  end

  def render_conflict(exception = nil)
    log_error(exception)
    render template: 'errors/409', status: 409
  end

  def render_unprocessable_entity(exception = nil)
    log_error(exception)
    render template: 'errors/422', status: 422
  end

  def render_internal_server_error(exception = nil)
    if exception
      Mailer::Error.create(exception, current_user, request).deliver_now
      logger.info "Rendering 500 with exception: #{exception.message}"
    end
    render template: 'errors/500', status: 500
  end

  def render_not_implemented(exception = nil)
    if exception
      Mailer::Error.create(exception, current_user, request).deliver_now
      logger.info "Rendering 501 with exception: #{exception.message}"
    end
    render template: 'errors/501', status: 501
  end

  def show
    raise request.env['action_dispatch.exception']
  end

  private

  def log_error(exception)
    return unless exception
    logger.info "#{exception.class} error has occurred with message: #{exception.message}"
  end
end
