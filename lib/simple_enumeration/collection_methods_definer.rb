# frozen_string_literal: true

module SimpleEnumeration
  class CollectionMethodsDefiner
    include Callee

    option :enum_class
    option :collection

    def call
      set_collection
      define_singleton_collection
      define_singleton_collection_values_method
      define_singleton_collection_value_predicate_method
      define_singleton_collection_for_select_method
      define_singleton_collection_humanized_method
      define_instance_collection_value_predicate_method
    end

    private

    def set_collection
      enum_class.set_collection(collection.name, collection)
    end

    def define_singleton_collection
      enum_class.define_singleton_method collection.method_name do
        collection_name = Collection.collection_name_from_method_name(__method__)

        get_collection(collection_name)
      end
    end

    def define_singleton_collection_values_method
      enum_class.define_singleton_method collection.value_method_name do
        collection_name = Collection.collection_name_from_value_method_name(__method__)

        get_collection(collection_name).types.values.map(&:converted_value)
      end
    end

    def define_singleton_collection_value_predicate_method
      enum_class.define_singleton_method collection.value_predicate_method_name do |converted_value|
        collection_name = Collection.collection_name_from_value_predicate_method_name(__method__)

        get_collection(collection_name).types.values.map(&:converted_value).include?(converted_value)
      end
    end

    def define_singleton_collection_for_select_method
      enum_class.define_singleton_method collection.for_select_method_name do
        collection_name = Collection.collection_name_from_for_select_method_name(__method__)

        get_collection(collection_name).types.values.map(&:for_select)
      end
    end

    def define_singleton_collection_humanized_method
      enum_class.define_singleton_method collection.humanized_method_name do
        collection_name = Collection.collection_name_from_humanized_method_name(__method__)

        get_collection(collection_name).types.values.map(&:humanized)
      end
    end

    def define_instance_collection_value_predicate_method
      enum_class.define_method collection.value_predicate_method_name do
        return false unless type

        collection_name = Collection.collection_name_from_value_predicate_method_name(__method__)

        self.class.get_collection(collection_name).types.values.map(&:converted_value).include?(type.converted_value)
      end
    end
  end
end
