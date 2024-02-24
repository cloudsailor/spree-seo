# frozen_string_literal: true

module Spree
  module Seo
    class SeoError < StandardError; end
  end
end

Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    resources :taxon_filter_combinations
  end
end
