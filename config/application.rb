require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Voodoo
  class Application < Rails::Application
    config.generators do |g|
      g.orm :active_record
      g.test_framework :rspec
      g.assets false
      g.helper false
      g.stylesheets false
    end

    config.sass.preferred_syntax = :sass
    config.active_record.raise_in_transactional_callbacks = true
  end
end
