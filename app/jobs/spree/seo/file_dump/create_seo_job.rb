module Spree
  module Seo
    module FileDump
      class CreateSeoJob < BaseSeoJob
        class CreateSeoJobError < StandardError; end

        # @param filename [String]
        # @param locale [String]
        def perform(filename, locale, args)
          envs.each do |env|
            path = "#{default_path}/#{env}/#{filename}"
            return unless load_file(path, locale) && seo_key_exists(locale)

            add_new_seo(locale, args)
            File.write(path, JSON.pretty_generate(@file))
          end
        rescue
          raise CreateSeoJobError.new("Error creating seo: #{$!.message}")
        end

        private

        def add_new_seo(locale, args)
          @file[locale]["seo"].append(args)
        end

        def seo_key_exists(locale)
          @file[locale] = {} unless @file.keys.include?(locale)
          @file[locale]["seo"] = [] unless @file[locale].keys.include?("seo")
          true
        end
      end
    end
  end
end
