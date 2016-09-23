module Constraints
  class TargetYear
    YEARS_LOWER_LIMIT = 2000
    YEARS_UPPER_LIMIT = 2100

    def self.matches?(request)
      target_year = request.query_parameters['target_year']&.to_i
      return true unless target_year
      (target_year >= YEARS_LOWER_LIMIT) && (target_year < YEARS_UPPER_LIMIT)
    end
  end
end
