# frozen_string_literal: true

module Spree
  module Admin
    class TaxonFilterCombinationsController < ::Spree::Admin::ResourceController
      include ::Spree::Admin::Translatable
      respond_to :html, :js

      def index; end

      def edit; end

      def new
        @object = ::FilterCombination.new(spree_taxon_id: params[:taxon_id])
      end

      def create
        invoke_callbacks(:create, :before)
        @object = ::FilterCombination.new(permitted_resource_params)

        if @object.save
          set_current_store
          invoke_callbacks(:create, :after)
          respond_with(@object) do |format|
            format.turbo_stream if update_turbo_stream_enabled?
            format.html do
              flash[:success] = flash_message_for(@object, :successfully_created)
              redirect_to location_after_save unless request.xhr?
            end
            format.js { render layout: false }
          end
        else
          invoke_callbacks(:create, :fails)
          respond_with(@object) do |format|
            format.html { render action: :new, status: :unprocessable_entity }
            format.js { render layout: false, status: :unprocessable_entity }
          end
        end
      end

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
