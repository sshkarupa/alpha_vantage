# frozen_string_literal: true

RSpec.describe AlphaVantage do
  it "has a version number" do
    expect(AlphaVantage::VERSION).not_to be nil
  end

  describe ".config" do
    let!(:config) { described_class.config }

    it "returns the config" do
      expect(config).to be_an_instance_of(AlphaVantage::Config)
    end

    context "without an api key" do
      it "raises an error" do
        expect { config.api_key }.to raise_error(AlphaVantage::ApiKeyMissing) do |e|
          expect(e.message).to eq("API key is missing")
        end
      end
    end

    context "with an api key" do
      before do
        AlphaVantage.configure do |config|
          config.api_key = "_api_key_"
        end
      end

      it "returns an api key" do
        expect(config.api_key).to eq("_api_key_")
      end
    end
  end
end
