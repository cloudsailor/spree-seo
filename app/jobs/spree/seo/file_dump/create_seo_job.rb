module Spree
  module Seo
    module FileDump
      class CreateSeoJob < ApplicationJob
        class CreateSeoJobError < StandardError; end

        # @param filename [String]
        # @param locale [String]
        def perform(filename, locale, args)
          @locale = locale
          @args  = args
          envs.each do |env|
            path = "#{default_path}/#{env}/#{filename}"
            return unless load_file(path) && seo_key_exists

            add_new_seo
            File.write(path, JSON.pretty_generate(@file))
          end
        rescue
          raise CreateSeoJobError
        end

        private

        def add_new_seo
          @file[@locale]["seo"].append(@args)
        end

        def seo_key_exists
          @file[@locale] = {} unless @file.keys.include?(@locale)
          @file[@locale]["seo"] = [] unless @file[@locale].keys.include?("seo")
          true
        end
      end
    end
  end
end
