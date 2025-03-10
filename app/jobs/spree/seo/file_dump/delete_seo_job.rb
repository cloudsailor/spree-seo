# frozen_string_literal: true

require 'English'

module Spree
  module Seo
    module FileDump
      # Job to delete seo dump from a file
      class DeleteSeoJob < BaseSeoJob
        class DeleteSeoFileJobError < StandardError; end

        # @param filename [String]
        # @param locale [String]
        def perform(filename, locale, args)
          envs.each do |env|
            path = "#{default_path}/#{env}/#{filename}"
            next unless load_file(path) && find_existing_key(args['seo_id'], locale)

            @seo_index.nil? ? next : remove_seo(locale)

            File.write(path, JSON.pretty_generate(@file))
          end
        rescue StandardError
          raise DeleteSeoFileJobError, "Error deleting seo: #{$ERROR_INFO.message}"
        end

        private

        def remove_seo(locale)
          @file[locale]['seo'].delete_at(@seo_index)
        end

        def find_existing_key(seo_id, locale)
          @seo_index = @file[locale]['seo'].empty? ? nil : @file[locale]['seo'].find_index { |x| x['seo_id'] == seo_id }
        rescue StandardError
          nil
        end

        def load_file(path)
          @file = JSON.load_file(path)
        rescue StandardError
          nil
        end
      end
    end
  end
end
