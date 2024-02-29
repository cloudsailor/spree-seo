# frozen_string_literal: true

Rails.application.config.after_initialize do
  Spree::Taxon.prepend Spree::Seo::TaxonDecorator

  Spree::Core::Engine.add_routes do
    namespace :admin, path: Spree.admin_path do
      resources :taxon_filter_combinations
    end
  end
end
