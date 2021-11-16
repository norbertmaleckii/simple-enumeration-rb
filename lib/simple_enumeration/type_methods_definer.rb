# frozen_string_literal: true

module SimpleEnumeration
  class TypeMethodsDefiner
    attr_reader :enum_class, :collection, :type

    def initialize(enum_class:, collection:, type:)
      @enum_class = enum_class
      @collection = collection
      @type = type
    end

    def self.call(*params, **options, &block)
      new(*params, **options).call(&block)
    end

    def call
      define_singleton_type_method
      define_singleton_type_value_method
      define_singleton_type_value_predicate_method
      define_instance_type_value_predicate_method
    end

    private

    def define_singleton_type_method
      enum_class.define_singleton_method type.method_name do
        type_value = Type.type_value_for_method_name(__method__)

        basic_collection.get_type(type_value)
      end
    end

    def define_singleton_type_value_method
      enum_class.define_singleton_method type.value_method_name do
        type_value = Type.type_value_for_value_method_name(__method__)

        basic_collection.get_type(type_value).converted_value
      end
    end

    def define_singleton_type_value_predicate_method
      enum_class.define_singleton_method type.value_predicate_method_name do |converted_value|
        type_value = Type.type_value_for_value_predicate_method_name(__method__)

        basic_collection.get_type(type_value).converted_value == converted_value
      end
    end

    def define_instance_type_value_predicate_method
      enum_class.define_method type.value_predicate_method_name do
        return false unless type

        type_value = Type.type_value_for_value_predicate_method_name(__method__)

        self.class.basic_collection.get_type(type_value).converted_value == type.converted_value
      end
    end
  end
end
