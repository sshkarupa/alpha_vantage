# frozen_string_literal: true

require "spec_helper"

RSpec.describe AlphaVantage::Validations do
  subject(:dummy) { Class.new { extend AlphaVantage::Validations } }

  let(:params) do
    {
      interval: "60min",
      datatype: "json",
      outputsize: "full",
      adjusted: "true",
      slice: "year1month1"
    }
  end

  shared_examples "raise an error" do |type|
    it "raise an error" do
      expect { dummy.send(:validate, params) }.to raise_error(AlphaVantage::ArgumentError) do |e|
        expect(e.message).to match(/Invalid #{type}/)
      end
    end
  end

  describe "#validate" do
    context "without invalid data" do
      it "returns an original hash" do
        expect(dummy.send(:validate, params)).to match(params)
      end
    end

    context "with invlid interval" do
      before { params[:interval] = "45min" }

      include_examples "raise an error", :interval
    end

    context "with invlid datatype" do
      before { params[:datatype] = "xlsx" }

      include_examples "raise an error", :datatype
    end

    context "with invlid outputsize" do
      before { params[:outputsize] = "short" }

      include_examples "raise an error", :outputsize
    end

    context "with invlid adjusted" do
      before { params[:adjusted] = "none" }

      include_examples "raise an error", :adjusted
    end

    context "with invlid slice" do
      before { params[:slice] = "year3month1" }

      include_examples "raise an error", :slice
    end
  end
end
