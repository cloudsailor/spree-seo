# frozen_string_literal: true

require_relative "seo/version"
require_relative "../filter_combination"
require_relative "seo/add_routes"

module Spree
  module Seo
    class SeoError < StandardError; end
  end
end
