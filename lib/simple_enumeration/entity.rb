# frozen_string_literal: true

module SimpleEnumeration
  class Entity
    attr_reader :converted_value

    def initialize(converted_value:)
      @converted_value = converted_value
    end

    def self.i18n_scope
      [
        'simple_enumeration',
        SimpleEnumeration.underscore(name.gsub('Enumeration', ''))
      ].join('.')
    end

    def self.define_basic_collection(*definitions)
      Collections::BasicFactory.call(
        enum_class: self,
        definitions: definitions
      )
    end

    def self.define_custom_collection(collection_name, *types)
      Collections::CustomFactory.call(
        enum_class: self,
        collection_name: collection_name,
        types: types
      )
    end

    def self.get_collection(name)
      instance_variable_get("@#{name}")
    end

    def self.set_collection(name, value)
      instance_variable_set("@#{name}", value)
    end

    def type
      @type ||= self.class.basic_collection.types.values.find do |type|
        type.converted_value.to_s == converted_value.to_s
      end
    end
  end
end
