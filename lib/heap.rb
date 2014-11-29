require 'httparty'

class Heap
  include HTTParty
  base_uri 'https://heapanalytics.com/api'
  headers "Content-Type" => "application/json"

  def self.app_id=(obj)
    @@app_id = obj
  end
  
  def self.app_id
    @@app_id
  end
  
  def self.event(event,identity=nil,properties=nil)
    return unless self.app_id
    body = { 
      app_id: self.app_id.to_s,
      event: event
    }
    body[:identity] = identity if identity
    body[:properties] = properties if properties.is_a? Hash
    post("/track",body:body.to_json)
  end

  def self.identify(identity,properties)
    return unless self.app_id
    body= {
      app_id: self.app_id.to_s,
      identity: identity
    }
    body[:properties] = properties if properties.is_a? Hash
    post("/identify",body:body.to_json)
  end

end