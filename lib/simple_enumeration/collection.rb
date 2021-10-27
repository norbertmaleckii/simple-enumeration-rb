# frozen_string_literal: true

module SimpleEnumeration
  class Collection
    extend Dry::Initializer

    MissingTypeError = Class.new(StandardError)

    option :name
    option :types, default: proc { {} }

    METHOD_NAME_SUFFIX = '_collection'
    VALUE_METHOD_NAME_SUFFIX = '_collection_values'
    VALUE_PREDICATE_METHOD_NAME_SUFFIX = '_collection_value?'
    FOR_SELECT_METHOD_NAME_SUFFIX = '_collection_for_select'
    HUMANIZED_METHOD_NAME_SUFFIX = '_collection_humanized'

    def self.collection_name_from_method_name(method_name)
      method_name.to_s.remove(METHOD_NAME_SUFFIX)
    end

    def self.collection_name_from_value_method_name(method_name)
      method_name.to_s.remove(VALUE_METHOD_NAME_SUFFIX)
    end

    def self.collection_name_from_value_predicate_method_name(method_name)
      method_name.to_s.remove(VALUE_PREDICATE_METHOD_NAME_SUFFIX)
    end

    def self.collection_name_from_for_select_method_name(method_name)
      method_name.to_s.remove(FOR_SELECT_METHOD_NAME_SUFFIX)
    end

    def self.collection_name_from_humanized_method_name(method_name)
      method_name.to_s.remove(HUMANIZED_METHOD_NAME_SUFFIX)
    end

    def method_name
      [name, METHOD_NAME_SUFFIX].join
    end

    def value_method_name
      [name, VALUE_METHOD_NAME_SUFFIX].join
    end

    def value_predicate_method_name
      [name, VALUE_PREDICATE_METHOD_NAME_SUFFIX].join
    end

    def for_select_method_name
      [name, FOR_SELECT_METHOD_NAME_SUFFIX].join
    end

    def humanized_method_name
      [name, HUMANIZED_METHOD_NAME_SUFFIX].join
    end

    def get_type(name)
      types[name].tap do |value|
        raise MissingTypeError, "Missing type for #{name}" unless value
      end
    end

    def add_type(name, value)
      types[name] = value
    end

    def remove_type(name)
      types[name] = nil
    end
  end
end
