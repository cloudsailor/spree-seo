# frozen_string_literal: true

module Spree
  module Seo
    # Base engine file
    class Engine < ::Rails::Engine
      isolate_namespace Spree::Seo
    end
  end
end
