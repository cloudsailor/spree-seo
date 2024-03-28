# frozen_string_literal: true

Rails.application.config.after_initialize do
  Spree::Taxon.prepend Spree::Seo::TaxonDecorator
  Spree::Api::V2::Platform::TaxonSerializer.prepend Spree::Api::V2::Platform::TaxonSerializerDecorator
  Rails.application.config.spree_backend.main_menu = Spree::Admin::MainMenu::SeoDefaultConfigurationBuilder.new.build
end
