module Constraints
  class MonthlyReportUser
    USER_ID_LIMIT = 1_000_000
    YEARS_LOWER_LIMIT = 2000
    YEARS_UPPER_LIMIT = 2100

    class << self
      def matches?(request)
        user_id = request.path_parameters[:user_id]&.to_i
        target_year = request.query_parameters['target_year']&.to_i
        valid_user_id?(user_id) && valid_year?(target_year)
      end

      def valid_user_id?(user_id)
        return true unless user_id
        user_id < USER_ID_LIMIT
      end

      def valid_year?(year)
        return true unless year
        (year >= YEARS_LOWER_LIMIT) && (year < YEARS_UPPER_LIMIT)
      end
    end
  end
end
