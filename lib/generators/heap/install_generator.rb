require 'rails/generators/base'

class Heap
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      def copy_initializer
        template "heap.rb", "config/initializers/heap.rb"
      end
    end
  end
end