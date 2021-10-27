# frozen_string_literal: true

module SimpleEnumeration
  module Collections
    class CustomFactory
      include Callee

      option :enum_class
      option :collection_name
      option :types

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
