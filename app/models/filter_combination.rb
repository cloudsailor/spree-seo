# frozen_string_literal: true

class FilterCombination < ActiveRecord::Base
  belongs_to :spree_taxon, class_name: 'Spree::Taxon'

  validates :locale, :canonical_url, :page_title, :meta_description, :keywords, :priority, presence: true
  validates :priority, inclusion: 0.0..1.0

  after_create -> {update_taxon_seo(:create)}
  before_save :format_filters
  after_save -> {update_taxon_seo(:update)}
  before_destroy -> {update_taxon_seo(:delete)}
  def format_filters
    dict = {}

    self.filters.split(',').each do |c|
      k, v = c.split('=')
      dict[k] = v
    end

    self.filters = dict
  end

  private
  def update_taxon_seo(action)
    Spree::Seo::FileDump::UpdateSeoService.new(self).call(action)
  end
end
