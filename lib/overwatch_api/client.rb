require 'httparty'
require 'json'

module OverwatchApi
  class Client
    include HTTParty

    # API base URL for overwatch
    base_uri 'https://overwatch-api.net/api/v1'.freeze

    def get(request_url)
      self.class.get(request_url)
    rescue HTTParty::Error => e
      abort e.message
    end

    def heros
      get('/hero/')
    end

    def hero(id)
      get("/hero/#{id}")
    end

    def abilities
      get('/ability/')
    end

    def ability(id)
      get("/ability/#{id}")
    end
  end
end