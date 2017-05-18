module Constraints
  class TargetMonth
    YEARS_LOWER_LIMIT = 2000
    YEARS_UPPER_LIMIT = 2100
    MONTHS_LOWER_LIMIT = 1
    MONTHS_UPPER_LIMIT = 12

    class << self
      def matches?(request)
        target_year = request.query_parameters['target_year']&.to_i
        target_month = request.query_parameters['target_month']&.to_i
        return true  if target_year.blank? && target_month.blank?
        return false if target_year.present? && target_month.blank?
        return false if target_year.blank? && target_month.present?
        return target_year.in?(YEARS_LOWER_LIMIT..YEARS_UPPER_LIMIT) && target_month.in?(MONTHS_LOWER_LIMIT..MONTHS_UPPER_LIMIT)
        return true #temp
      end
    end
  end
end
