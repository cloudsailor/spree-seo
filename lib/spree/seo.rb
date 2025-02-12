require "spree/seo/version"
require "spree/seo/engine"

ENGINE_PATH = File.expand_path('../../lib/spree/seo/engine', __FILE__)

require 'rails/all'
require 'spree_core'
require 'spree_api'

require_relative "seo/version"

module Spree
  module Seo
    # Your code goes here...
  end
end
