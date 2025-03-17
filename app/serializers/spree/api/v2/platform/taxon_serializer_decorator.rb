# frozen_string_literal: true

module Spree
  module Api
    module V2
      module Platform
        # Adds filter_combinations to Taxon serializer
        # rubocop:disable Layout/LineLength
        module TaxonSerializerDecorator
          def self.prepended(base) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
            base.has_many :filter_combinations, record_type: :filter_combination

            base.attribute(:available_combinations) do |taxon|
              taxon.filter_combinations.map(&:attributes)
            end
            base.attribute(:combinations_html) do |taxon|
              headings = "<thead><th>Locale</th><th>Filters</th><th>Canonical URL</th><th>Page Title</th><th>Meta Description</th><th class='text-center'>Actions</th></thead>"
              data = taxon.filter_combinations.map do |f|
                "<tr><td>#{f.locale}</td><td>#{f.filters.map do |k, v|
                  "#{k}=#{v}"
                end.join(',')}</td><td>#{f.canonical_url}</td><td>#{f.page_title}</td><td>#{f.meta_description}</td><td class='actions'><span><a class='edit' href='/admin/taxon_filter_combinations/#{f.id}/edit'>Edit</a></span></td></tr>"
              end.join
              body = "<tbody>#{data}</tbody>"

              "<div class='table-responsive border rounded bg-white'><a class='mt-3 ml-3 btn btn-success' href='/admin/taxon_filter_combinations/new?taxon_id=#{taxon.id}'>New Combination</a><table class='table'>#{headings}#{body}</table></div>"
            end
          end
        end
        # rubocop:enable Layout/LineLength
      end
    end
  end
end

if Spree::Api::V2::Platform::TaxonSerializer.included_modules
                                            .exclude?(Spree::Api::V2::Platform::TaxonSerializerDecorator)
  Spree::Api::V2::Platform::TaxonSerializer.prepend Spree::Api::V2::Platform::TaxonSerializerDecorator
end
