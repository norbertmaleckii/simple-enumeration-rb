# frozen_string_literal: true

module SimpleEnumeration
  module DefineSimpleEnumeration
    def define_simple_enumeration(attribute, options = {})
      enum_class = options[:with] || const_get([attribute.to_s.camelcase, 'Enumeration'].join)

      define_method "#{attribute}_enumeration" do
        enum_class.new(converted_value: send(attribute))
      end
    end
  end
end
