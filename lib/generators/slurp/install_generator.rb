require 'securerandom'

module Slurp
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Slurp initializer and copy locale files to your application."
      class_option :orm

      def copy_initializer
        template "slurp.rb", "config/initializers/slurp.rb"
      end

      def copy_locale
        copy_file "../../../config/locales/en.yml", "config/locales/slurp.en.yml"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
