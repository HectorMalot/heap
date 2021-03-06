require 'httparty'
require 'heap/events'
require 'heap/railtie' if defined?(Rails)

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

  def self.default_handle_type=(value)
    @@handle_type = value
  end

  def self.default_handle_type
    @@handle_type ||= 'email'
  end
end
