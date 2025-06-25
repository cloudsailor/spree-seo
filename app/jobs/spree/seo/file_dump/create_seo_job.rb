# frozen_string_literal: true

require 'English'

module Spree
  module Seo
    module FileDump
      # Job to dump seo to filters file.
      # If higher tier keys are missing - they are added as well
      class CreateSeoJob < BaseSeoJob
        class CreateSeoJobError < StandardError; end

        # @param filename [String]
        # @param locale [String]
        def perform(filename, locale, args)
          envs.each do |env|
            path = "#{default_path}/#{env}/#{filename}"
            next unless load_file(path, locale) && seo_key_exists?(locale)

            add_new_seo(locale, args)
            File.write(path, JSON.pretty_generate(@file))
          end
        rescue StandardError
          raise CreateSeoJobError, "Error creating seo: #{$ERROR_INFO.message}"
        end

        private

        def add_new_seo(locale, args)
          @file[locale]['seo'].append(args)
        end

        def seo_key_exists?(locale)
          @file[locale] = {} unless @file.keys.include?(locale)
          @file[locale]['seo'] = [] unless @file[locale].keys.include?('seo')
          true
        end
      end
    end
  end
end
