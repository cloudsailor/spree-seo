# frozen_string_literal: true

module Spree
  module Admin
    class TaxonFilterCombinationsController < ::Spree::Admin::ResourceController
      include ::Spree::Admin::Translatable
      respond_to :html, :js

      def index; end

      def edit; end

      def model_class
        ::FilterCombination
      end

      def collection_url(options = {})
        spree.polymorphic_url([:admin, :taxon_filter_combinations], options)
      end

      private

      def permitted_resource_params
        params.require(:filter_combination).permit(:spree_taxon_id, :locale, :filters,
                                                   :canonical_url, :page_title, :meta_description,
                                                   :keywords, :custom_h1, :custom_h2,
                                                   :seo_description, :priority)
      end
    end
  end
end
