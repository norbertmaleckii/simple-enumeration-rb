# frozen_string_literal: true

module SimpleEnumeration
  class TypeMethodsDefiner
    include Callee

    option :enum_class
    option :collection
    option :type

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
