# frozen_string_literal: true

# Model to store filters and seo for a taxon.
class FilterCombination < ApplicationRecord
  belongs_to :spree_taxon, class_name: '::Spree::Taxon'

  validates :locale, :canonical_url, :page_title, :meta_description, :keywords, :priority, presence: true
  validates :priority, inclusion: 0.0..1.0

  before_save :format_filters
  after_create -> { update_taxon_seo(:create) }
  after_update -> { update_taxon_seo(:update) }
  before_destroy -> { update_taxon_seo(:delete) }

  def format_filters
    dict = {}

    filters.split(';').each do |c|
      k, v = c.split('=')
      dict[k] = v
    end

    self.filters = dict
  end

  def ops
    @ops ||=
      begin
        products_scope = spree_taxon.products
        product_properties = Spree::ProductProperties::FindAvailable.new(products_scope:).execute
        Spree::Filters::PropertiesPresenter.new(product_properties_scope: product_properties).to_a
      end
  end

  private

  def update_taxon_seo(action)
    Spree::Seo::FileDump::UpdateSeoService.new(self).call(action)
  end
end
