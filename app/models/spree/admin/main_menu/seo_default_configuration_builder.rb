# frozen_string_literal: true

module Spree
  module Admin
    module MainMenu
      class SeoDefaultConfigurationBuilder < DefaultConfigurationBuilder
        def add_products_section(root)
          items = [
            ItemBuilder.new('products', admin_products_path).with_match_path('/products').build,
            ItemBuilder.new('option_types', admin_option_types_path).
              with_admin_ability_check(Spree::OptionType).
              with_match_path('/option_types').
              build,
            ItemBuilder.new('properties', admin_properties_path).
              with_admin_ability_check(Spree::Property).
              build,
            ItemBuilder.new('prototypes', admin_prototypes_path).
              with_admin_ability_check(Spree::Prototype).
              build,
            ItemBuilder.new('taxonomies', admin_taxonomies_path).
              with_admin_ability_check(Spree::Taxonomy).
              with_match_path('/taxonomies').
              build,
            ItemBuilder.new('taxons', admin_taxons_path).
              with_admin_ability_check(Spree::Taxon).
              with_match_path('/taxons').
              build,
            ItemBuilder.new('taxon_filter_combinations', admin_taxon_filter_combinations_path).
              with_admin_ability_check(Spree::Taxon).
              with_match_path('/taxon_filter_combinations').
              build
          ]

          section = SectionBuilder.new('products', 'tags-fill.svg').
                    with_admin_ability_check(Spree::Product).
                    with_items(items).
                    build
          root.add(section)
        end
      end
    end
  end
end
