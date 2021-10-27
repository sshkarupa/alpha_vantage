# frozen_string_literal: true

require "spec_helper"

RSpec.describe AlphaVantage::Client do
  subject(:client) { described_class }

  let(:url) { "https://www.alphavantage.co/query?apikey=_api_key_&datatype=json&function=SYMBOL_SEARCH&keywords=tesla" }
  let(:response) { Net::HTTPSuccess.new(1.0, "200", "OK") }

  before do
    allow(response).to receive(:body).and_return({BestMatches: []}.to_json)
    allow(Net::HTTP).to receive(:get_response).with(URI.parse(url)).and_return(response)
  end

  describe ".get" do
    it "makes an api call" do
      client.get(function: "SYMBOL_SEARCH", keywords: "tesla")
      expect(Net::HTTP).to have_received(:get_response).once
    end

    it "returns a struct object" do
      result = client.get(function: "SYMBOL_SEARCH", keywords: "tesla")
      expect(result).to have_attributes(best_matches: [])
    end
  end
end
