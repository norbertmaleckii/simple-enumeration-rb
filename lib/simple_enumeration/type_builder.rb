# frozen_string_literal: true

module SimpleEnumeration
  class TypeBuilder
    include Callee

    option :enum_class
    option :definition

    def call
      factory_klass.call(
        enum_class: enum_class,
        definition: definition
      )
    end

    def factory_klass
      if definition.is_a?(Hash)
        Types::HashFactory
      else
        Types::StringFactory
      end
    end
  end
end
