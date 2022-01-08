# frozen_string_literal: true

module SimpleEnumeration
  module DefineSimpleEnumeration
    def define_simple_enumeration(attribute, options = {})
      enum_class_name = options[:with] || enum_class_name_for(attribute)
      enum_class = enum_class_name.is_a?(String) ? const_get(enum_class_name) : enum_class_name

      define_method "#{attribute}_enumeration" do
        enum_class.new(converted_value: send(attribute))
      end
    end

    def enum_class_name_for(attribute)
      [
        SimpleEnumeration.camelcase(attribute.to_s),
        'Enumeration'
      ].join
    end
  end
end
