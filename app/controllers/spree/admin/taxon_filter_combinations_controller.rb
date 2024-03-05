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

      private

      def filter_combination_params
        params.require(:filter_combination).permit(:spree_taxon_id, :locale, :filters,
                                                   :canonical_url, :page_title, :meta_description,
                                                   :keywords, :custom_h1, :custom_h2,
                                                   :seo_description, :priority)
      end
    end
  end
end
