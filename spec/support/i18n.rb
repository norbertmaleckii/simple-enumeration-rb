# frozen_string_literal: true

I18n.load_path << Dir["#{File.expand_path('spec/support/locales')}/**/*.yml"]
I18n.available_locales = %w[pl]
I18n.default_locale = :pl
