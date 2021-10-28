# frozen_string_literal: true

module AlphaVantage
  module Validations
    VALID_VALUES = {
      interval: %w[1min 5min 15min 30min 60min],
      datatype: %w[json csv],
      outputsize: %w[compact full],
      adjusted: %w[true false],
      slice: slaces
    }.freeze

    private

    def validate(params)
      params.each { |key, value| validate_type(key, value) if VALID_VALUES.keys.include?(key) }
    end

    def validate_type(type, value)
      values = VALID_VALUES[type]
      return if values.include?(value)

      raise ArgumentError, "Invalid #{type}, only allowed: #{values.join(', ')}"
    end

    def slices
      @slaces ||= (1..2).map do |year|
        (1..12).map { |month| "year#{year}month#{month}".to_sym }
      end.flatten
    end
  end
end
