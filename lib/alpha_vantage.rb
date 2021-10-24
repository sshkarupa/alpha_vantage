# frozen_string_literal: true

require "ruby-next"
require "ruby-next/language/setup"
RubyNext::Language.setup_gem_load_path(transpile: true)

require_relative "alpha_vantage/version"
require_relative "alpha_vantage/ext/deep_transform"
require_relative "alpha_vantage/ext/string"
require_relative "alpha_vantage/ext/hash"

require_relative "alpha_vantage/client"

module AlphaVantage
  using RubyNext

  class Error < StandardError; end

  class ApiKeyMissing < Error; end

  class << self
    def config
      @config ||= Config.new
    end

    def configure
      yield(config)
    end
  end

  class Config
    attr_writer :api_key
    def api_key
      return @api_key if instance_variable_defined?(:@api_key)

      raise ApiKeyMissing, "API key is missing"
    end

    def base_url = "https://www.alphavantage.co/query"
  end
end
