require 'helper'

class String
  def html_safe
    self
  end
end

class HeapHelperTest < MiniTest::Test
  include Heap::ViewHelpers

  should "produce correct identify handle type" #do
    # handle = '123'
    # assert_equal heap_identify(handle), "heap.identify({email: \"#{handle}\" });"
  # end
  def javascript_tag(options = {})
    yield
  end

  def raw(js)
    js
  end

  should "set event properties from arbitrary key-value pairs" do
    js = heap_set_event_properties({
      :first => "first value",
      "second" => 2,
      :third => true
    })

    assert_equal js, %Q/heap.setEventProperties({"first":"first value","second":2,"third":true});/
  end
end
