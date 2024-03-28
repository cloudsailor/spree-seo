# frozen_string_literal: true

module Spree
  module Seo
    class Engine < ::Rails::Engine
      isolate_namespace Spree::Seo
    end
  end
end
