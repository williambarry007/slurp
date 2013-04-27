module Slurp
  module Generators
    class SlurpGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      namespace "slurp"
      source_root File.expand_path("../templates", __FILE__)

      desc "Generates a model with the given NAME (if one does not exist) with slurp " <<
           "configuration plus a migration file and slurp routes."

      hook_for :orm

      class_option :routes, :desc => "Generate routes", :type => :boolean, :default => true

      def add_slurp_routes
        slurp_route  = "slurp_for :#{plural_name}"
        slurp_route << %Q(, :class_name => "#{class_name}") if class_name.include?("::")
        slurp_route << %Q(, :skip => :all) unless options.routes?
        route slurp_route
      end
    end
  end
end
