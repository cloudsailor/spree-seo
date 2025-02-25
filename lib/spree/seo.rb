# frozen_string_literal: true

require 'spree/seo/version'
require 'spree/seo/engine'

ENGINE_PATH = File.expand_path('../lib/spree/seo/engine', __dir__)

require 'rails/all'
require 'spree_core'
require 'spree_api'

require_relative 'seo/version'

module Spree
  # Base module
  module Seo
    # Your code goes here...
  end
end
