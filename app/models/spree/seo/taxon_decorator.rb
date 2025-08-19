# frozen_string_literal: true

module Spree
  module Seo
    # Adds filter-combinations association
    module TaxonDecorator
      def self.prepended(base)
        base.has_many :filter_combinations,
                      class_name: 'FilterCombination',
                      foreign_key: :spree_taxon_id,
                      inverse_of: :spree_taxon,
                      dependent: :destroy
      end
    end
  end
end

Spree::Taxon.prepend Spree::Seo::TaxonDecorator if Spree::Taxon.included_modules.exclude?(Spree::Seo::TaxonDecorator)
