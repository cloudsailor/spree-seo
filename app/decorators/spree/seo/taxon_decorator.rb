# frozen_string_literal: true

module Spree
  module Seo
    module TaxonDecorator
      def self.prepended(base)
        base.has_many :filter_combinations, foreign_key: 'spree_taxon_id'
      end
    end
  end
end
