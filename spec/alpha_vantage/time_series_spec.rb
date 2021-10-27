# frozen_string_literal: true

require "spec_helper"

RSpec.describe AlphaVantage::TimeSeries do
  subject(:time_series) { described_class.new(symbol: symbol) }

  describe ".search" do
    let!(:body) { open_fixture_file("time_series/search.json") }
    let!(:result) { yaml_fixture_file("time_series/search.yml") }

    before do
      stub_request(:get, "https://www.alphavantage.co/query")
        .with(query: {apikey: "_api_key_", function: "SYMBOL_SEARCH", keywords: "tesco", datatype: "json"})
        .to_return(body: body, headers: {"Content-Type" => "application/json"})
    end

    it "returns a search result" do
      expect(described_class.search(keywords: "tesco")).to match_array(result)
    end
  end

  describe "#intraday"
  describe "#daily"
  describe "#weekly"
  describe "#monthly"
  describe "quote"
end
