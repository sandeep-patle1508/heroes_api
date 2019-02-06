require 'httparty'
require 'json'

module OverwatchApi
  class Client
    include HTTParty

    # API base URL for overwatch
    base_uri 'https://overwatch-api.net/api/v1'.freeze

    def initialize(options)
      @request_url = options[:request_url]
    end

    def get
      self.class.get("/#{@request_url}")
    rescue HTTParty::Error => e
      abort e.message
    end
  end
end