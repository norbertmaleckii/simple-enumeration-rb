# frozen_string_literal: true

module SimpleEnumeration
  module Types
    class StringFactory < BaseFactory
      def value
        definition.to_s
      end

      def converted_value
        definition.to_s
      end
    end
  end
end
