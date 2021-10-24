# frozen_string_literal: true

require "spec_helper"

RSpec.describe AlphaVantage::Ext::String do
  using AlphaVantage::Ext::String

  describe "#normalize" do
    context "when valid date" do
      let(:source) { "2021-10-08" }

      it "returns an original string" do
        expect(source.normalize).to eq(source)
      end
    end

    context "when not a date" do
      let(:source) { "12. Important information (ClientABC)" }
      let(:result) { :important_information_client_abc }

      it "transforms a string" do
        expect(source.normalize).to eq(result)
      end
    end
  end

  describe "#underscore" do
    let(:source) { "AA::BB-123-ClientID" }
    let(:result) { "aa/bb_123_client_id" }

    it "makes an underscored, lowercase" do
      expect(source.underscore).to eq(result)
    end
  end

  describe "#sanitize" do
    let(:source) { "1. Information (very): /important/" }
    let(:result) { "Information_very_important" }

    it "returns a sanitized string" do
      expect(source.sanitize).to eq(result)
    end
  end

  describe "#valid_date?" do
    context "when valid date" do
      it "returns true" do
        %w[2021-12-10 2001-01-02 2010-12-23].each do |str|
          expect(str.valid_date?).to be_truthy
        end
      end
    end

    context "when invalid date" do
      it "returns false" do
        %w[2021-12-32 2001-13-02 12-101-201].each do |str|
          expect(str.valid_date?).to be_falsey
        end
      end
    end
  end
end
