module Spree
  module Seo
    module FileDump
      class UpdateSeoJob < BaseSeoJob
        class UpdateSeoJobError < StandardError; end

        # @param filename [String]
        # @param locale [String]
        def perform(filename, locale, args)
          @locale = locale
          @args  = args
          envs.each do |env|
            path = "#{default_path}/#{env}/#{filename}"
            return unless load_file(path) && seo_key_exists

            @seo_index = find_existing_key
            if @seo_index.nil?
              add_new_seo
            else
              update_seo
            end

            File.write(path, JSON.pretty_generate(@file))
          end
        rescue
          raise UpdateSeoJobError
        end

        private
        def add_new_seo
          @file[@locale]["seo"].append(@args)
        end

        def update_seo
          @file[@locale]["seo"][@seo_index] = @args
        end

        def seo_key_exists
          @file[@locale] = {} unless @file.keys.include?(@locale)
          @file[@locale]["seo"] = [] unless @file[@locale].keys.include?("seo")
          true
        end

        def find_existing_key
          available_languages.each do |language|
            next if @file[language].empty? || @file[language]["seo"].empty?
            return if @file[@locale]["seo"].find_index { |x| x["seo_id"] == @args["seo_id"]}
          end
        end
      end
    end
  end
end
