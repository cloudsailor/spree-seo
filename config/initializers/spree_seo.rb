# frozen_string_literal: true

Rails.application.config.after_initialize do
  Spree::Taxon.prepend Spree::Seo::TaxonDecorator
  Rails.application.config.spree_backend.main_menu = Spree::Admin::MainMenu::SeoDefaultConfigurationBuilder.new.build
end
