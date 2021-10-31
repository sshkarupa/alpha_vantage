# frozen_string_literal: true

require "spec_helper"

RSpec.describe AlphaVantage::TimeSeries do
  subject(:time_series) { described_class.new(symbol: "IBM") }

  let(:base_query) { {apikey: "_api_key_", symbol: "IBM", datatype: "json"} }

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

  describe "#intraday" do
    let!(:body) { open_fixture_file("time_series/intraday.json") }
    let!(:result) { yaml_fixture_file("time_series/intraday.yml") }
    let(:query) do
      base_query.merge(function: "TIME_SERIES_INTRADAY", interval: "5min", adjusted: true, outputsize: "compact")
    end

    before do
      stub_request(:get, "https://www.alphavantage.co/query")
        .with(query: query)
        .to_return(body: body, headers: {"Content-Type" => "application/json"})
    end

    it "returns an intraday data" do
      expect(time_series.intraday.time_series_5min).to match_array(result)
    end
  end

  describe "#intraday_extended" do
    let!(:body) { read_fixture_file("time_series/intraday_ext.csv") }
    let!(:result) { CSV.parse(body) }
    let(:query) do
      base_query.merge(
        function: "TIME_SERIES_INTRADAY_EXTENDED", interval: "5min", adjusted: true, outputsize: "compact",
        datatype: "csv", slice: "year1month1"
      )
    end

    before do
      stub_request(:get, "https://www.alphavantage.co/query")
        .with(query: query)
        .to_return(body: body, headers: {})
    end

    it "returns an intraday data" do
      expect(time_series.intraday_extended).to match_array(result)
    end
  end

  describe "#daily"
  describe "#weekly"
  describe "#monthly"
  describe "quote"
end
