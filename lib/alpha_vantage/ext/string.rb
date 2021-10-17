# frozen_string_literal: true

module AlphaVantage
  module Ext
    module String
      refine ::String do
        def underscore
          gsub(/::/, "/").
          gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
          gsub(/([a-z\d])([A-Z])/, '\1_\2').
          tr("-", "_").
          downcase
        end

        def normalize
          return self if is_date?

          sanitize.underscore.to_sym
        end

        def sanitize
          tr(".():/","").gsub(/^\d+.?\s/, "").tr(" ", "_")
        end

        def is_date?
          !/(\d{4}-\d{2}-\d{2})/.match(self).nil?
        end
      end

      using self
    end
  end
end
