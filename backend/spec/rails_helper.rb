ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'spec_helper'
require 'rspec/rails'
require 'factory_bot'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  FactoryBot.define do
    to_create { |instance| instance.save }
  end
end
