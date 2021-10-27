# frozen_string_literal: true

require_relative 'lib/simple_enumeration/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_enumeration'
  spec.version       = SimpleEnumeration::VERSION
  spec.authors       = ['Norbert Małecki']
  spec.email         = ['norbert.malecki@icloud.com']

  spec.summary       = 'Enumerations system for Ruby with awesome features!'
  spec.description   = [
    'Helps you to declare enumerations in a very simple and flexible way.',
    'Define your enumerations in classes, it means you can add new behaviour and also reuse them.'
  ].join(' ')

  spec.homepage      = 'https://github.com/norbertmaleckii/simple-enumeration-rb'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.5.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'callee'
  spec.add_dependency 'dry-initializer'
  spec.add_dependency 'i18n'

  spec.add_development_dependency 'pry'
end
