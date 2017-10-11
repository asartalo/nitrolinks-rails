require_relative 'boot'

# Pick the frameworks you want:
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)
require "nitrolinks/rails"

module Dummy
  class Application < Rails::Application
    config.load_defaults 5.1
  end
end

