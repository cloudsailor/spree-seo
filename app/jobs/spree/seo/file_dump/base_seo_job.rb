# frozen_string_literal: true

module Spree
  module Seo
    module FileDump
      # Base job for seo content management
      class BaseSeoJob < ApplicationJob
        def default_path
          Rails.public_path.join('files').to_s
        end

        def envs
          %w[test prod]
        end

        def available_languages
          %w[en sk cs]
        end

        def load_file(path, locale)
          @file = JSON.load_file(path)
        rescue StandardError
          # Create new file if it does not exist
          File.write(path, JSON.pretty_generate({ "#{locale}": {} }))

          @file = JSON.load_file(path)
        end
      end
    end
  end
end
