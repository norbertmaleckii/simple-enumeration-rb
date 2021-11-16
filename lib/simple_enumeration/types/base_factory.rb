# frozen_string_literal: true

module SimpleEnumeration
  module Types
    class BaseFactory
      attr_reader :enum_class, :definition

      def initialize(enum_class:, definition:)
        @enum_class = enum_class
        @definition = definition
      end

      def self.call(*params, **options, &block)
        new(*params, **options).call(&block)
      end

      def call
        Type.new(
          definition: definition,
          value: value,
          converted_value: converted_value,
          enum_class: enum_class
        )
      end
    end
  end
end
