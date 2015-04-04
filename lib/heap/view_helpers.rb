require 'json'

class Heap
  module ViewHelpers
    def heap_analytics
      heap_js_block %Q{
        window.heap=window.heap||[],heap.load=function(t,e){window.heap.appid=t,window.heap.config=e;var a=document.createElement("script");a.type="text/javascript",a.async=!0,a.src=("https:"===document.location.protocol?"https:":"http:")+"//cdn.heapanalytics.com/js/heap-"+t+".js";var n=document.getElementsByTagName("script")[0];n.parentNode.insertBefore(a,n);for(var o=function(t){return function(){heap.push([t].concat(Array.prototype.slice.call(arguments,0)))}},p=["clearEventProperties","identify","setEventProperties","track","unsetEventProperty"],c=0;c<p.length;c++)heap[p[c]]=o(p[c])};
        heap.load("#{Heap.app_id}");
      }
    end

    def heap_identify(handle, properties = nil)
      body = properties.map {|k,v| ", #{k}: \"#{v}\""}.join if properties.is_a? Hash
      heap_js_block %Q{heap.identify({#{Heap.default_handle_type}: "#{handle}" #{body}});}
    end

    def heap_set_event_properties(properties = {})
      heap_js_block %Q{heap.setEventProperties(#{properties.to_json});}
    end

    def heap_js_block(content)
      javascript_tag :type => "text/javascript" do
        raw content.html_safe
      end
    end
  end
end
