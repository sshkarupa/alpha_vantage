# frozen_string_literal: true

module AlphaVantage
  module Ext
    module Hash
      refine ::Hash do
        def to_struct
          keys.empty? ? self : Struct.new(*keys).new(*values)
        end
      end

      using self
    end
  end
end
