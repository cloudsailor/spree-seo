# frozen_string_literal = true
require 'active_record'

class FilterCombination < ActiveRecord::Base
  belongs_to :spree_taxon
end
