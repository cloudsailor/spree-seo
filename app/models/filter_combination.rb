# frozen_string_literal: true

# Model to store filters and seo for a taxon.
class FilterCombination < ApplicationRecord
  belongs_to :spree_taxon, class_name: '::Spree::Taxon'

  # This can be either video or picture
  has_one_attached :icon

  validates :locale, :canonical_url, :page_title, :meta_description, :keywords, :priority, presence: true
  validates :priority, inclusion: 0.0..1.0
  validate :acceptable_media

  before_save :format_filters
  after_create -> { update_taxon_seo(:create) }
  after_update -> { update_taxon_seo(:update) }
  before_destroy -> { update_taxon_seo(:delete) }

  def format_filters
    dict = {}

    filters.split(';').each do |c|
      k, v = c.split('=')
      dict[k] = v
    end

    self.filters = dict
  end

  def product_options
    @product_options ||=
      begin
        products_scope = spree_taxon.products
        product_properties = Spree::ProductProperties::FindAvailable.new(products_scope:).execute
        Spree::Filters::PropertiesPresenter.new(product_properties_scope: product_properties).to_a
      end
  end

  def update_taxon_seo(action)
    Spree::Seo::FileDump::UpdateSeoService.new(self).call(action)
  end

  private

  def acceptable_media
    return unless icon.attached?

    case icon.content_type
    when %r{\Aimage/(jpeg|jpg|png|svg|avif|webp)\z}
      errors.add(:icon, 'Picture is too big (max 100KB)') if icon.byte_size > 100.kilobytes
    when 'video/mp4'
      errors.add(:icon, 'Video is too big (max 5MB)') if icon.byte_size > 5.megabytes
    else
      errors.add(:icon, 'must be a JPG/PNG/WebP image or an MP4 video')
    end
  end
end
