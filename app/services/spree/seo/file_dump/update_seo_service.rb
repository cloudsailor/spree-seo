# frozen_string_literal: true
include Rails.application.routes.url_helpers

module Spree
  module Seo
    module FileDump
      # Handles seo changes
      class UpdateSeoService
        # @param
        # seo_object: [FilterCombination]
        def initialize(seo_object)
          @seo = seo_object
        end

        def call(action)
          case action
          when :create
            Spree::Seo::FileDump::CreateSeoJob.perform_async(filename, locale, create_args)
          when :update
            Spree::Seo::FileDump::UpdateSeoJob.perform_async(filename, locale, update_args)
          when :delete
            Spree::Seo::FileDump::DeleteSeoJob.perform_async(filename, locale, remove_args)
          end
        end

        private

        def filename
          "#{@seo&.spree_taxon&.id}-filters.json"
        end

        def locale
          @seo&.locale
        end

        # Recurrence to fetch parent icon if is absent for @seo
        def icon_url(parent: @seo, url: nil)
          if parent.is_a?(FilterCombination)
            return Rails.application.routes.url_helpers.url_for(@seo.icon) if @seo.icon.present? && @seo.icon.save
            
            url = icon_url(parent: @seo.spree_taxon) || 'Not found'
          end
          
          if url.nil?
            debugger
            return Rails.application.routes.url_helpers.url_for(parent.icon.attachment) if parent.icon.present?
            return nil if parent.parent.nil?

            url = icon_url(parent: parent.parent)
          end
            
          url
        end

        def create_args # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
          {
            'seo_id' => @seo.id,
            'filters' => @seo&.filters,
            'seo_description' => @seo&.seo_description,
            'custom_h1' => @seo&.custom_h1,
            'custom_h2' => @seo&.custom_h2,
            'page_title' => @seo&.page_title,
            'canonical_url' => @seo&.canonical_url,
            'meta_description' => @seo&.meta_description,
            'keywords' => @seo&.keywords,
            'priority' => @seo&.priority,
            'icon_url' => icon_url
          }
        end

        def update_args
          create_args
        end

        def remove_args
          {
            'seo_id' => @seo.id
          }
        end
      end
    end
  end
end
