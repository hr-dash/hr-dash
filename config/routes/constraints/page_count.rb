module Constraints
  class PageCount
    PAGE_COUNT_LIMIT = 100_000

    def self.matches?(request)
      return true unless request.query_parameters['page']
      request.query_parameters['page'].to_i <= PAGE_COUNT_LIMIT
    end
  end
end
