# frozen_string_literal: true

require 'i18n'

require_relative 'simple_enumeration/version'
require_relative 'simple_enumeration/type'
require_relative 'simple_enumeration/types/base_factory'
require_relative 'simple_enumeration/types/hash_factory'
require_relative 'simple_enumeration/types/string_factory'
require_relative 'simple_enumeration/type_builder'
require_relative 'simple_enumeration/type_methods_definer'
require_relative 'simple_enumeration/collection'
require_relative 'simple_enumeration/collections/basic_factory'
require_relative 'simple_enumeration/collections/custom_factory'
require_relative 'simple_enumeration/collection_methods_definer'
require_relative 'simple_enumeration/entity'
require_relative 'simple_enumeration/utils'
require_relative 'simple_enumeration/object_helper'

module SimpleEnumeration
end
