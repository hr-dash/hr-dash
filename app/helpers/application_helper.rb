# frozen_string_literal: true
require 'month'

module ApplicationHelper
  def alert_class_for(flash_type)
    types = {
      success: 'alert-success',
      notice: 'alert-info',
      alert: 'alert-warning',
      error: 'alert-danger',
    }
    types[flash_type.to_sym]
  end

  def all_months_begin_select_options(first_month, last_month)
    (Month(first_month)..Month(last_month)).map(&:start_date).map { |month| [month.strftime('%Y年%m月'), month] }
  end

  def all_months_end_select_options(first_month, last_month)
    (Month(first_month)..Month(last_month)).map(&:end_date).map { |month| [month.strftime('%Y年%m月'), month] }
  end
end
