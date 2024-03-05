# frozen_string_literal: true

module Spree
  module Api
    module V2
      module Platform
        class FilterCombinationSerializer < BaseSerializer
          attributes(:spree_taxon, :locale, :filters, :canonical_url, :page_title, :meta_description,
                     :keywords, :custom_h1, :custom_h2, :seo_description, :priority)
        end
      end
    end
  end
end
