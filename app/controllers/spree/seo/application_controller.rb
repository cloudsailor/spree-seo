# frozen_string_literal: true

module Spree
  module Seo
    # Base application controller
    class ApplicationController < ActionController::Base
      protect_from_forgery with: :exception
    end
  end
end
