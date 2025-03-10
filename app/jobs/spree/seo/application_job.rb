# frozen_string_literal: true

module Spree
  module Seo
    class ApplicationJob
      include Sidekiq::Job
    end
  end
end
