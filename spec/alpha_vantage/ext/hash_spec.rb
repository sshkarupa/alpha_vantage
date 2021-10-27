# frozen_string_literal: true

require "spec_helper"

RSpec.describe AlphaVantage::Ext::Hash do
  using AlphaVantage::Ext::Hash

  describe "#to_struct" do
    context "without data" do
      let(:source) { {} }

      it "returns self" do
        expect(source.to_struct).to eq(source)
      end
    end

    context "with data" do
      let(:source) { {a: 1, b: 2} }

      it "returns a struct" do
        struct = source.to_struct
        expect(struct).to be_kind_of(Struct)
        expect(struct).to have_attributes(a: 1, b: 2)
      end
    end
  end
end
