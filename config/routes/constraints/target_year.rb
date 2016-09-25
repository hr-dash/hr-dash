module Constraints
  class TargetYear
    YEARS_LOWER_LIMIT = 2000
    YEARS_UPPER_LIMIT = 2100

    class << self
      def matches?(request)
        target_year = request.query_parameters['target_year']&.to_i
        return true unless target_year
        target_year.in?(YEARS_LOWER_LIMIT..YEARS_UPPER_LIMIT)
      end
    end
  end
end
