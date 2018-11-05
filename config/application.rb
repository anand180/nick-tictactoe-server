require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Tictactoe
  class Application < Rails::Application
    config.load_defaults 5.2

    config.action_controller.forgery_protection_origin_check = false

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'localhost:8080'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :patch, :options], credentials: true
      end
    end
  end
end
