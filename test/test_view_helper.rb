require 'helper'

class String
  def html_safe
    self
  end
end

class HeapHelperTest < MiniTest::Test
  include Heap::ViewHelpers

  def javascript_tag(options = {})
    yield
  end

  def raw(js)
    js
  end

  should "produce correct identify handle type" do
    handle = '123'
    assert_equal heap_identify(handle), "heap.identify({email: \"#{handle}\" });"
  end

  should "set event properties from arbitrary key-value pairs" do
    js = heap_set_event_properties({
      :first => "first value",
      "second" => 2,
      :third => true
    })

    assert_equal js, %Q/heap.setEventProperties({"first":"first value","second":2,"third":true});/
  end

  should "set load properties key-value pairs" do

    Heap.app_id = '123'

    js = heap_analytics({
      forceSSL: true,
      secureCookie: true,
      disableTextCapture: true
    })

    assert_includes js, %Q/heap.load("123", {forceSSL: true, secureCookie: true, disableTextCapture: true});/
  end
end
