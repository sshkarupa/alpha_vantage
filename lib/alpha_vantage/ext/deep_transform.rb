# frozen_string_literal: true

require_relative "string"

module AlphaVantage
  module Ext
    using AlphaVantage::Ext::String

    module DeepTranform
      refine ::Array do
        def deep_transform
          map(&:deep_transform)
        end
      end

      refine ::Hash do
        def deep_transform
          self.class[map { |k, v| [k.to_s.normalize, v.deep_transform] }]
        end
      end

      refine ::Object do
        def deep_transform
          self
        end
      end

      using self
    end
  end
end
