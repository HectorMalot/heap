require 'heap/view_helpers'

class Heap
  class Railtie < Rails::Railtie
    initializer "heap.view_helpers" do
      ActiveSupport.on_load( :action_view ){ include Heap::ViewHelpers }
    end
  end
end