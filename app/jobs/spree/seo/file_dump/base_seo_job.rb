module Spree
  module Seo
    module FileDump
      class BaseSeoJob < ApplicationJob
        def default_path
          "#{Rails.root}/public/files"
        end

        def envs
          %w[test prod]
        end

        def available_languages
          %w[en sk cs]
        end

        def load_file(path, locale)
          @file = JSON.load_file(path)
        rescue
          # Create new file if it does not exist
          File.open(path, 'w') do |file|
            file.write(JSON.pretty_generate({"#{locale}": {}}))
          end

          @file = JSON.load_file(path)
        end
      end
    end
  end
end
