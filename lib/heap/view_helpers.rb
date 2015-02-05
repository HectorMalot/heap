class Heap
  module ViewHelpers
    def heap_analytics
      javascript_tag :type => "text/javascript" do
        raw %Q{
          window.heap=window.heap||[],heap.load=function(t,e){window.heap.appid=t,window.heap.config=e;var a=document.createElement("script");a.type="text/javascript",a.async=!0,a.src=("https:"===document.location.protocol?"https:":"http:")+"//cdn.heapanalytics.com/js/heap-"+t+".js";var n=document.getElementsByTagName("script")[0];n.parentNode.insertBefore(a,n);for(var o=function(t){return function(){heap.push([t].concat(Array.prototype.slice.call(arguments,0)))}},p=["clearEventProperties","identify","setEventProperties","track","unsetEventProperty"],c=0;c<p.length;c++)heap[p[c]]=o(p[c])};
          heap.load("#{Heap.app_id}");
          }.html_safe
      end
    end

    def heap_identify(email, properties=nil)
      body = properties.map {|k,v| ", #{k}: \"#{v}\""}.join if properties.is_a? Hash
      javascript_tag do
        raw %Q{heap.identify({email: "#{email}" #{body}}); }.html_safe
      end

    end
  end
end
