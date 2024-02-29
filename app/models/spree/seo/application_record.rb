module Spree
  module Seo
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
