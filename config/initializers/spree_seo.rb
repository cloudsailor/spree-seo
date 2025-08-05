# frozen_string_literal: true

Rails.application.config.after_initialize do
  Rails.application.config.spree_backend.main_menu = Spree::Admin::MainMenu::SeoDefaultConfigurationBuilder.new.build
  Rails.application.config.action_mailer.default_url_options = { :host => ENV.fetch('APP_HOST', nil) }

  # Only apply decorators if the spree_taxons table exists
  if ActiveRecord::Base.connection.data_source_exists?('spree_taxons')
    Spree::Api::V2::Platform::TaxonSerializer.prepend Spree::Api::V2::Platform::TaxonSerializerDecorator
    Spree::Taxon.prepend Spree::TaxonDecorator
  end
end
