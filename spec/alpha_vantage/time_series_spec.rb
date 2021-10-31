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

  describe "#quote" do
    let!(:body) { open_fixture_file("time_series/quote.json") }
    let!(:result) { yaml_fixture_file("time_series/quote.yml") }
    let(:query) { base_query.merge(function: "GLOBAL_QUOTE") }

    before do
      stub_request(:get, "https://www.alphavantage.co/query")
        .with(query: query)
        .to_return(body: body, headers: {"Content-Type" => "application/json"})
    end

    it "returns a global quote" do
      expect(time_series.quote).to match_array(result)
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

  describe "#daily" do
    context "when adjusted: false" do
      let!(:body) { open_fixture_file("time_series/daily.json") }
      let!(:result) { yaml_fixture_file("time_series/daily.yml") }
      let(:query) do
        base_query.merge(function: "TIME_SERIES_DAILY", interval: "5min", outputsize: "compact")
      end

      before do
        stub_request(:get, "https://www.alphavantage.co/query")
          .with(query: query)
          .to_return(body: body, headers: {"Content-Type" => "application/json"})
      end

      it "returns a daily data" do
        expect(time_series.daily.time_series_daily).to match_array(result)
      end
    end

    context "when adjusted: true" do
      let!(:body) { open_fixture_file("time_series/daily_adjusted.json") }
      let!(:result) { yaml_fixture_file("time_series/daily_adjusted.yml") }
      let(:query) do
        base_query.merge(function: "TIME_SERIES_DAILY_ADJUSTED", interval: "5min", outputsize: "compact")
      end

      before do
        stub_request(:get, "https://www.alphavantage.co/query")
          .with(query: query)
          .to_return(body: body, headers: {"Content-Type" => "application/json"})
      end

      it "returns a daily data" do
        expect(time_series.daily(adjusted: true).time_series_daily).to match_array(result)
      end
    end
  end

  describe "#weekly" do
    context "when adjusted: false" do
      let!(:body) { open_fixture_file("time_series/weekly.json") }
      let!(:result) { yaml_fixture_file("time_series/weekly.yml") }
      let(:query) { base_query.merge(function: "TIME_SERIES_WEEKLY") }

      before do
        stub_request(:get, "https://www.alphavantage.co/query")
          .with(query: query)
          .to_return(body: body, headers: {"Content-Type" => "application/json"})
      end

      it "returns a daily data" do
        expect(time_series.weekly.weekly_time_series).to match_array(result)
      end
    end

    context "when adjusted: true" do
      let!(:body) { open_fixture_file("time_series/weekly_adjusted.json") }
      let!(:result) { yaml_fixture_file("time_series/weekly_adjusted.yml") }
      let(:query) { base_query.merge(function: "TIME_SERIES_WEEKLY_ADJUSTED") }

      before do
        stub_request(:get, "https://www.alphavantage.co/query")
          .with(query: query)
          .to_return(body: body, headers: {"Content-Type" => "application/json"})
      end

      it "returns a daily data" do
        expect(time_series.weekly(adjusted: true).weekly_adjusted_time_series).to match_array(result)
      end
    end
  end

  describe "#monthly" do
    context "when adjusted: false" do
      let!(:body) { open_fixture_file("time_series/monthly.json") }
      let!(:result) { yaml_fixture_file("time_series/monthly.yml") }
      let(:query) { base_query.merge(function: "TIME_SERIES_MONTHLY") }

      before do
        stub_request(:get, "https://www.alphavantage.co/query")
          .with(query: query)
          .to_return(body: body, headers: {"Content-Type" => "application/json"})
      end

      it "returns a daily data" do
        expect(time_series.monthly.monthly_time_series).to match_array(result)
      end
    end

    context "when adjusted: true" do
      let!(:body) { open_fixture_file("time_series/monthly_adjusted.json") }
      let!(:result) { yaml_fixture_file("time_series/monthly_adjusted.yml") }
      let(:query) { base_query.merge(function: "TIME_SERIES_MONTHLY_ADJUSTED") }

      before do
        stub_request(:get, "https://www.alphavantage.co/query")
          .with(query: query)
          .to_return(body: body, headers: {"Content-Type" => "application/json"})
      end

      it "returns a daily data" do
        expect(time_series.monthly(adjusted: true).monthly_adjusted_time_series).to match_array(result)
      end
    end
  end
end
