# frozen_string_literal: true

module SimpleEnumeration
  module Types
    class HashFactory < BaseFactory
      def value
        definition.first.first.to_s
      end

      def converted_value
        definition.first.last.to_s
      end
    end
  end
end
