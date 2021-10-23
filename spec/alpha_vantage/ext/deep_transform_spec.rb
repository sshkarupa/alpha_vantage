# frozen_string_literal: true

require "spec_helper"

RSpec.describe AlphaVantage::Ext::DeepTranform do
  using AlphaVantage::Ext::DeepTranform

  describe "nested arrays and hashes" do
    let(:source) do
      {
        "1 first" => {
          "b" => {"1.1 one" => "123. hello", "1.2. two" => "world"},
          "c" => {"1.3. One" => "12345", "1.4. Two" => "12345"}
        },
        "2. second" => [{"2.1 one" => "hello"}, {"2.2 two" => "world"}]
      }
    end
    let(:result) do
      {
        first: {
          b: { one: "123. hello", two: "world"},
          c: {one: "12345", two: "12345"}
        },
        second: [{one: "hello"}, {two: "world"}]
      }
    end

    it "transforms data" do
      expect(source.deep_transform).to eq(result)
    end
  end

  describe "other objects" do
    it "returns self" do
      [1, "1. one", :a].each do |obj|
        expect(obj.deep_transform).to eq(obj)
      end
    end
  end
end
