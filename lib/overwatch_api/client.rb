require 'httparty'
require 'json'

module OverwatchApi
  class Client
    include HTTParty

    # API base URL for overwatch
    base_uri ENV['OVERWATCH_BASE_URI']

    # make get call
    # TODO: SSL verfication is disable here, need to install SSL certificate
    def get(request_url)
      self.class.get(request_url, verify: false)
    rescue HTTParty::Error => e
      abort e.message
    end

    # call hero api to get list of heros
    def heros
      get('/hero/')
    end

    # call hero api to get requested hero detail
    def hero(id)
      get("/hero/#{id}")
    end

    # call hero api to get list of abilities
    def abilities
      get('/ability/')
    end

    # call hero api to get requested ability detail
    def ability(id)
      get("/ability/#{id}")
    end
  end
end