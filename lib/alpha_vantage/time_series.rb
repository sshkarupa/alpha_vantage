# frozen_string_literal: true

module AlphaVantage
  class TimeSeries
    include Validations

    FUNCTIONS = {
      search: "SYMBOL_SEARCH",
      intraday: "TIME_SERIES_INTRADAY"
    }.freeze

    def self.search(keywords:)
      Client.get(function: FUNCTIONS[:search], keywords: keywords).best_matches
    end

    attr_reader :symbol

    def initialize(symbol:)
      @symbol = symbol
    end

    def intraday(**opts)
      params = {
        function: FUNCTIONS[:intraday],
        symbol: symbol,
        outputsize: opts.fetch(:outputsize, "compact"),
        interval: opts.fetch(:interval, "5min"),
        datatype: opts.fetch(:datatype, "json"),
        adjusted: opts.fetch(:adjusted, true).to_s
      }.then(&method(:validate))

      Client.get(**params)
    end
  end
end
