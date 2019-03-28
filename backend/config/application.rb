require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"

Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application

    config.load_defaults 5.1
    config.generators.system_tests = nil

    # config.active_record.raise_in_transactional_callbacks = true
  end
end
