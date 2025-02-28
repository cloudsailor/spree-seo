# frozen_string_literal: true

require_relative '../migration_generator'

module Spree
  module Seo
    # Gem installation class
    class InstallGenerator < MigrationGenerator
      MYSQL_ADAPTERS = [
        'ActiveRecord::ConnectionAdapters::MysqlAdapter',
        'ActiveRecord::ConnectionAdapters::Mysql2Adapter'
      ].freeze
      source_root File.expand_path('templates', __dir__)

      desc 'Generates (but does not run) a migration to add a versions table.  ' \
           'See section 5.c. Generators in README.md for more information.'

      def create_migration_file
        add_seo_migration('create_filter_combinations')
      end

      private

      # MySQL 5.6 utf8mb4 limit is 191 chars for keys used in indexes.
      # See https://github.com/paper-trail-gem/paper_trail/issues/651
      def item_type_options
        if mysql?
          ', null: false, limit: 191'
        else
          ', null: false'
        end
      end

      def mysql?
        MYSQL_ADAPTERS.include?(ActiveRecord::Base.connection.class.name)
      end

      # Even modern versions of MySQL still use `latin1` as the default character
      # encoding. Many users are not aware of this, and run into trouble when they
      # try to use PaperTrail in apps that otherwise tend to use UTF-8. Postgres, by
      # comparison, uses UTF-8 except in the unusual case where the OS is configured
      # with a custom locale.
      #
      # - https://dev.mysql.com/doc/refman/5.7/en/charset-applications.html
      # - http://www.postgresql.org/docs/9.4/static/multibyte.html
      #
      # Furthermore, MySQL's original implementation of UTF-8 was flawed, and had
      # to be fixed later by introducing a new charset, `utf8mb4`.
      #
      # - https://mathiasbynens.be/notes/mysql-utf8mb4
      # - https://dev.mysql.com/doc/refman/5.5/en/charset-unicode-utf8mb4.html
      #
      def versions_table_options
        if mysql?
          ', options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci"'
        else
          ''
        end
      end
    end
  end
end
