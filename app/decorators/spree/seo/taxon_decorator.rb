# frozen_string_literal: true

module Spree
  module Seo
    module TaxonDecorator
      def self.prepended(base)
        base.has_many :filter_combinations, foreign_key: 'spree_taxon_id' if ActiveRecord::Base.connection.tables.include?('filter_combinations')
      end
    end
  end
end
