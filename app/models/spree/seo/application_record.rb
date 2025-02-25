# frozen_string_literal: true

module Spree
  module Seo
    # Base class for applicationr ecord
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
