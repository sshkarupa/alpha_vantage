# frozen_string_literal: true

module AlphaVantage
  module Ext
    module String
      refine ::String do
        require "date"

        def normalize
          valid_date? ? self : sanitize.underscore.to_sym
        end

        def underscore
          gsub(/::/, "/")
            .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
            .gsub(/([a-z\d])([A-Z])/, '\1_\2')
            .tr("-", "_")
            .downcase
        end

        def sanitize
          tr(".():/", "").gsub(/^\d+.?\s/, "").tr(" ", "_")
        end

        def valid_date?
          !!Date.strptime(self, "%Y-%m-%d") rescue false # rubocop:disable Style/RescueModifier
        end
      end

      using self
    end
  end
end
