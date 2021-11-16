# frozen_string_literal: true

module SimpleEnumeration
  module Collections
    class BasicFactory
      attr_reader :enum_class, :definitions

      def initialize(enum_class:, definitions:)
        @enum_class = enum_class
        @definitions = definitions
      end

      def self.call(*params, **options, &block)
        new(*params, **options).call(&block)
      end

      def call
        collection = Collection.new(name: :basic)

        CollectionMethodsDefiner.call(enum_class: enum_class, collection: collection)

        definitions.each do |definition|
          type = TypeBuilder.call(definition: definition, enum_class: enum_class)

          TypeMethodsDefiner.call(enum_class: enum_class, collection: collection, type: type)

          collection.add_type(type.value, type)
        end

        collection
      end
    end
  end
end
