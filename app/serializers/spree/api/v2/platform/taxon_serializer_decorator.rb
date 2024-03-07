# frozen_string_literal: true

module Spree
  module Api
    module V2
      module Platform
        module TaxonSerializerDecorator
          def self.prepended(base)
            base.has_many :filter_combinations, record_type: :filter_combination

            base.attribute(:available_combinations) do |taxon|
              taxon.filter_combinations.map(&:attributes)
            end

            base.attribute(:combinations_html) do |taxon|
              headings = "<thead><th>Locale</th><th>Filters</th><th>Canonical URL</th><th>Page Title</th><th>Meta Description</th><th class='text-center'>Actions</th></thead>"
              body = "<tbody>#{taxon.filter_combinations.map { |f| "<td>#{f.locale}</td><td>#{f.filters.map { |k, v| "#{k}=#{v}"}.join(',')}<td><td>#{f.canonical_url}</td><td>#{f.page_title}</td><td>#{f.meta_description}</td><td class='actions'><span><a class='edit' href='/admin/taxon_filter_combinations/#{f.id}/edit'>Edit</a></span></td>"}.join('')}</tbody>"

              "<div class='table-responsive border rounded bg-white'><a class='btn btn-success' href='/admin/taxon_filter_combinations/new'>New Combination</a><table class='table'>#{headings}#{body}</table></div>"
            end
          end
        end
      end
    end
  end
end
