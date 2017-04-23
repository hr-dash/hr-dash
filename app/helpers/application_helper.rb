# frozen_string_literal: true
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

  def all_months_select_options(first_month, last_month)
    all_months(first_month, last_month).map { |month| [month.strftime('%Y年%m月'), month] }
  end

  def all_months(first_month, last_month)
    (Month(first_month)..Month(last_month)).map(&:start_date)
  end
end
