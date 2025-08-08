# frozen_string_literal: true

require 'English'

module Spree
  module Seo
    module FileDump
      # Updates existing seo dump
      class UpdateSeoJob < BaseSeoJob
        class UpdateSeoJobError < StandardError; end

        # @param filename [String]
        # @param locale [String]
        def perform(filename, locale, args)
          envs.each do |env|
            process_environment(env, filename, locale, args)
          end
        rescue StandardError
          raise UpdateSeoJobError, "Error updating seo: #{$ERROR_INFO.message}"
        end

        private

        def process_environment(env, filename, locale, args)
          path = path(env, filename)
          return unless load_file(path, locale) && seo_key_exists?(locale)

          @seo_index ||= find_existing_key(args)
          handle_seo_update(@seo_index, locale, args, filename)
          update_file(path)
        end

        def handle_seo_update(seo_index, locale, args, filename)
          if seo_index&.fetch(:language, nil) == locale
            update_seo(seo_index[:language], args, seo_index[:index])
          elsif seo_index&.fetch(:language, nil)
            add_new_seo(locale, args)
            delete_old_seo(filename, seo_index[:language], { 'seo_id' => args['seo_id'] })
          else
            add_new_seo(locale, args)
          end
        end

        def update_file(path)
          File.write(path, JSON.pretty_generate(@file))
        end

        def path(env, filename)
          "#{default_path}/#{env}/#{filename}"
        end

        def add_new_seo(locale, args)
          @file[locale]['seo'].append(args)
        end

        def update_seo(locale, args, index)
          @file[locale]['seo'][index] = args
        end

        def seo_key_exists?(locale)
          @file[locale] = {} unless @file.keys.include?(locale)
          @file[locale]['seo'] = [] unless @file[locale].keys.include?('seo')
          true
        end

        def find_existing_key(args)
          available_languages.each do |language|
            next if @file[language].nil? || @file[language]['seo'].nil?

            index = @file[language]['seo'].find_index { |x| x['seo_id'] == args['seo_id'] }
            return { index:, language: } unless index.nil?
          end
          nil
        end

        def delete_old_seo(filename, locale, remove_args)
          Spree::Seo::FileDump::DeleteSeoJob.perform_async(filename, locale, remove_args)
        end
      end
    end
  end
end
