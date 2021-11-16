# frozen_string_literal: true

module SimpleEnumeration
  class Type
    attr_reader :definition, :value, :converted_value, :enum_class

    def initialize(definition:, value:, converted_value:, enum_class:)
      @definition = definition
      @value = value
      @converted_value = converted_value
      @enum_class = enum_class
    end

    VALUE_METHOD_NAME_SUFFIX = '_value'
    VALUE_PREDICATE_METHOD_NAME_SUFFIX = '_value?'

    def self.type_value_for_method_name(method_name)
      method_name.to_s
    end

    def self.type_value_for_value_method_name(method_name)
      method_name.to_s.gsub(VALUE_METHOD_NAME_SUFFIX, '')
    end

    def self.type_value_for_value_predicate_method_name(method_name)
      method_name.to_s.gsub(VALUE_PREDICATE_METHOD_NAME_SUFFIX, '')
    end

    def method_name
      value
    end

    def value_method_name
      [value, VALUE_METHOD_NAME_SUFFIX].join
    end

    def value_predicate_method_name
      [value, VALUE_PREDICATE_METHOD_NAME_SUFFIX].join
    end

    def for_select
      [humanized, converted_value]
    end

    def humanized
      translations[:text]
    end

    def meta
      translations.except(:text)
    end

    def translations
      I18n.t(
        value,
        raise: true,
        scope: enum_class.i18n_scope
      )
    end
  end
end
