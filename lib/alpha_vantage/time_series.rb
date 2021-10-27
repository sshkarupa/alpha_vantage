# frozen_string_literal: true

module AlphaVantage
  class TimeSeries
    FUNCTIONS = {
      search: "SYMBOL_SEARCH"
    }

    def self.search(keywords:)
      Client.get(function: FUNCTIONS[:search], keywords: keywords).best_matches
    end
  end
end
