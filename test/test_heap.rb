require 'helper'

class TestHeap < MiniTest::Test
  should "post events to https://heapanalytics.com/api/track" do
    stub_request(:post, "https://heapanalytics.com/api/track").
      with(:body => {:app_id => '123', :event => 'test', :identity => 'test@example.com', :properties => {:property1 => 'hello', :property2 => 'world'}},
         :headers => {'Content-Type'=>'application/json'}).
      to_return(:body => "OK")

    Heap.app_id = 123
    result = Heap.event('test','test@example.com', :property1 => 'hello', :property2 => 'world')
    assert_equal result.to_s, "OK"
  end

  should "post identities to https://heapanalytics.com/api/identify" do
    stub_request(:post, "https://heapanalytics.com/api/identify").
      with(:body => {:app_id => '123', :identity => 'test@example.com', :properties => {:property1 => 'hello', :property2 => 'world'}},
         :headers => {'Content-Type'=>'application/json'}).
      to_return(:body => "{}")

    Heap.app_id = 123
    result = Heap.identify('test@example.com', :property1 => 'hello', :property2 => 'world')
    assert_equal result.to_s, "{}"
  end

  should "default to email handler" do
    assert_equal Heap.default_handle_type, 'email'
  end

  should "allow to change the handler" do
    Heap.default_handle_type = 'handle'
    assert_equal Heap.default_handle_type, 'handle'
    Heap.default_handle_type = nil
  end
end
