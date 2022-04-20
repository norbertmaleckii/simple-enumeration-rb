# frozen_string_literal: true

module SimpleEnumeration
  module ObjectHelper
    def define_simple_enumeration(attribute, options = {})
      enum_class_name = options[:with] || [
        Utils.camelcase(attribute.to_s),
        'Enumeration'
      ].join

      enum_class = enum_class_name.is_a?(String) ? const_get(enum_class_name) : enum_class_name

      define_method "#{attribute}_enumeration" do
        enum_class.new(converted_value: send(attribute))
      end
    end
  end
end
