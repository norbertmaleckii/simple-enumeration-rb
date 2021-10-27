# frozen_string_literal: true

module SimpleEnumeration
  module Types
    class BaseFactory
      include Callee

      option :definition
      option :enum_class

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
