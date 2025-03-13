# frozen_string_literal: true

module Spree
  # Base taxon decorator
  module TaxonDecorator
    def self.prepended(base)
      base.has_many :filter_combinations, foreign_key: 'spree_taxon_id'
    end
  end
end
Spree::Taxon.prepend Spree::TaxonDecorator if Spree::Taxon.included_modules.exclude?(Spree::TaxonDecorator)
