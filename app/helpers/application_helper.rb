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

  def all_months_select_options(first_month, last_month, end_of_month_flg = false)
    all_months(first_month, last_month, end_of_month_flg).map { |month| [month.strftime('%Y年%m月'), month] }
  end

  def all_months(first_month, last_month, end_of_month_flg = false)
    months = Month(first_month)..Month(last_month)
    end_of_month_flg ? months.map(&:end_date) : months.map(&:start_date)
  end
end
