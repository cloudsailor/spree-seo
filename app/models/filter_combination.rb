# frozen_string_literal: true

class FilterCombination < ActiveRecord::Base
  belongs_to :spree_taxon, class_name: 'Spree::Taxon'

  validates :locale, :canonical_url, :page_title, :meta_description, :keywords, :priority, presence: true
  validates :priority, inclusion: 0.0..1.0

  before_save :format_filters

  def format_filters
    dict = {}

    self.filters.split(',').each do |c|
      k, v = c.split('=')
      dict[k] = v
    end

    self.filters = dict
  end
end
