require "spree/seo/version"
require "spree/seo/engine"

ENGINE_ROOT = File.expand_path('../..', __FILE__)
ENGINE_PATH = File.expand_path('../../lib/spree/seo/engine', __FILE__)

require 'rails/all'
require 'rails/engine/commands'
require 'spree_core'
require 'spree_api'

require_relative "seo/version"

module Spree
  module Seo
    # Your code goes here...
  end
end
