# frozen_string_literal: true

module SimpleEnumeration
  module Collections
    class BasicFactory
      include Callee

      option :enum_class
      option :collection_name, default: proc { :basic }
      option :definitions

      def call
        collection = Collection.new(name: collection_name)

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
