# frozen_string_literal: true

module AlphaVantage
  class TimeSeries
    include Validations

    FUNCTIONS = {
      search: "SYMBOL_SEARCH",
      intraday: "TIME_SERIES_INTRADAY",
      intraday_extended: "TIME_SERIES_INTRADAY_EXTENDED",
      daily: "TIME_SERIES_DAILY",
      daily_adjusted: "TIME_SERIES_DAILY_ADJUSTED",
      weekly: "TIME_SERIES_WEEKLY",
      weekly_adjusted: "TIME_SERIES_WEEKLY_ADJUSTED",
      monthly: "TIME_SERIES_MONTHLY",
      monthly_adjusted: "TIME_SERIES_MONTHLY_ADJUSTED",
      quote: "GLOBAL_QUOTE"
    }.freeze

    def self.search(keywords:)
      Client.get(function: FUNCTIONS[:search], keywords: keywords).best_matches
    end

    attr_reader :symbol

    def initialize(symbol:)
      @symbol = symbol
    end

    def quote
      Client.get(function: FUNCTIONS[:quote], symbol: symbol).global_quote
    end

    def intraday(**opts)
      params = {
        datatype: opts.fetch(:datatype, "json"),
        outputsize: opts.fetch(:outputsize, "compact"),
        interval: opts.fetch(:interval, "5min"),
        adjusted: opts.fetch(:adjusted, true).to_s
      }.then(&method(:validate))

      Client.get(function: FUNCTIONS[:intraday], symbol: symbol, **params)
    end

    def intraday_extended(**opts)
      params = {
        datatype: "csv",
        outputsize: opts.fetch(:outputsize, "compact"),
        interval: opts.fetch(:interval, "5min"),
        adjusted: opts.fetch(:adjusted, true).to_s,
        slice: opts.fetch(:slice, "year1month1")
      }.then(&method(:validate))

      Client.get(function: FUNCTIONS[:intraday_extended], symbol: symbol, **params)
    end

    def daily(adjusted: false, **opts)
      params = {
        datatype: opts.fetch(:datatype, "json"),
        outputsize: opts.fetch(:outputsize, "compact"),
        interval: opts.fetch(:interval, "5min")
      }.then(&method(:validate))

      function = adjusted ? FUNCTIONS[:daily_adjusted] : FUNCTIONS[:daily]
      Client.get(function: function, symbol: symbol, **params)
    end

    def weekly(adjusted: false, **opts)
      params = {
        datatype: opts.fetch(:datatype, "json")
      }.then(&method(:validate))

      function = adjusted ? FUNCTIONS[:weekly_adjusted] : FUNCTIONS[:weekly]
      Client.get(function: function, symbol: symbol, **params)
    end

    def monthly(adjusted: false, **opts)
      params = {
        datatype: opts.fetch(:datatype, "json")
      }.then(&method(:validate))

      function = adjusted ? FUNCTIONS[:monthly_adjusted] : FUNCTIONS[:monthly]
      Client.get(function: function, symbol: symbol, **params)
    end
  end
end
