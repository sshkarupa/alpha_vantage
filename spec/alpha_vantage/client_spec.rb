# frozen_string_literal: true

require "spec_helper"

RSpec.describe AlphaVantage::Client do
  subject(:client) { described_class }

  let!(:raw_data) do
    [
      {
        "1. symbol": "TSLA",
        "2. name": "Equity",
        "3. type": "Equity",
        "4. region": "United States",
        "5. marketOpen": "09:30",
        "6. marketClose": "16:00",
        "7. timezone": "UTC-04",
        "8. currency": "USD",
        "9. matchScore": "0.8889"
      }
    ]
  end

  let!(:data) do
    {
      symbol: "TSLA",
      name: "Equity",
      type: "Equity",
      region: "United States",
      market_open: "09:30",
      market_close: "16:00",
      timezone: "UTC-04",
      currency: "USD",
      match_score: "0.8889"
    }
  end

  before do
    stub_request(:get, "https://www.alphavantage.co/query")
      .with(query: {apikey: "_api_key_", function: "SYMBOL_SEARCH", keywords: "tesla", datatype: "json"})
      .to_return(body: {"bestMatches" => raw_data}.to_json, headers: {"Content-Type" => "application/json"})
  end

  describe ".get" do
    it "makes api call" do
      result = client.get(function: "SYMBOL_SEARCH", keywords: "tesla")
      expect(result).to have_attributes(best_matches: [data])
    end
  end
end
