# frozen_string_literal: true

module SimpleEnumeration
  module Utils
    def self.camelcase(string)
      string.split('_').map do |w|
        w[0] = w[0].upcase
        w
      end.join
    end

    def self.underscore(string)
      string
        .gsub('::', '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .downcase
    end
  end
end
