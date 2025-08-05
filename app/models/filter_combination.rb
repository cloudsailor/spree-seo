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

  def acceptable_media # rubocop:disable Metrics/AbcSize
    return unless icon.attached?

    size = icon.byte_size
    case icon.content_type
    when image_type
      errors.add(:icon, t(:'errors.picture_too_big')) if size > 100.kilobytes
    when video_type
      errors.add(:icon, t('errors.video_too_big')) if size > 5.megabytes
    else
      errors.add(:icon, t(:'errors.wrong_icon_format'))
    end
  end

  def image_type
    %r{\Aimage/(jpeg|jpg|png|svg|avif|webp)\z}
  end

  def video_type
    'video/mp4'
  end
end
