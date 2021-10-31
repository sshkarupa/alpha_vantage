# frozen_string_literal: true

require "uri"
require "net/http"
require "open-uri"
require "csv"
require "json"

module AlphaVantage
  using AlphaVantage::Ext::DeepTranform
  using AlphaVantage::Ext::Hash

  class Client
    ALL_NET_HTTP_ERRORS = [
      ::Timeout::Error,
      ::Errno::EINVAL,
      ::Errno::ECONNRESET,
      ::EOFError,
      ::Net::HTTPBadResponse,
      ::Net::HTTPHeaderSyntaxError,
      ::Net::ProtocolError
    ].freeze

    def self.get(datatype: "json", **opts)
      new(datatype: datatype, **opts).public_send(datatype)
    end

    attr_reader :opts
    def initialize(**opts)
      @opts = opts
    end

    def json
      JSON.parse(request)
        .then(&:deep_transform)
        .then(&:to_struct)
    end

    def csv
      raw_data = request
      CSV.parse(raw_data)
    rescue CSV::MalformedCSVError => _e
      error_response = JSON.parse(raw_data)
      message = error_response["Error Message"] || error_response
      raise AlphaVantage::Error, message
    end

    private

    def request
      uri.query = URI.encode_www_form(default_params.merge(**opts))
      response = Net::HTTP.get_response(uri)
      response.body if response.is_a?(Net::HTTPSuccess)
    rescue *ALL_NET_HTTP_ERRORS => e
      raise AlphaVantage::Error, e.message
    end

    def uri
      @uri ||= URI.parse(config.base_url)
    end

    def default_params
      @default_params ||= {apikey: config.api_key}
    end

    def config
      @config ||= AlphaVantage.config
    end
  end
end
