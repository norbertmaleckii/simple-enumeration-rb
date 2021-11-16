# frozen_string_literal: true

module SimpleEnumeration
  module Collections
    class CustomFactory
      attr_reader :enum_class, :collection_name, :types

      def initialize(enum_class:, collection_name:, types:)
        @enum_class = enum_class
        @collection_name = collection_name
        @types = types
      end

      def self.call(*params, **options, &block)
        new(*params, **options).call(&block)
      end

      def call
        collection = Collection.new(name: collection_name)

        CollectionMethodsDefiner.call(enum_class: enum_class, collection: collection)

        types.each do |type|
          collection.add_type(type.value, type)
        end

        collection
      end
    end
  end
end
