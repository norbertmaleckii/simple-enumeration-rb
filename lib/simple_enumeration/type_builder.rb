# frozen_string_literal: true

module SimpleEnumeration
  class TypeBuilder
    attr_reader :enum_class, :definition

    def initialize(enum_class:, definition:)
      @enum_class = enum_class
      @definition = definition
    end

    def self.call(*params, **options, &block)
      new(*params, **options).call(&block)
    end

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
