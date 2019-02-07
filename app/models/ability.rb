class Ability < BaseModel
  attr_accessor :id, :name, :description, :is_ultimate

  def initialize(data_hash)
    @id = data_hash['id']
    @name = data_hash['name']
    @description = data_hash['description']
    @is_ultimate = data_hash['is_ultimate']
  end

  # call Overwatch abilities API to get list of abilities
  # return: Array of Ability objects
  def self.all
    api_response = OverwatchApi::Client.new.abilities
    if is_success_response?(api_response)
      api_response['data'] ? api_response['data'].map { |data| new(data) } : []
    end
  end
  
  # call Overwatch ability API with given ID
  # return: Ability object
  def self.find(id)
    api_response = OverwatchApi::Client.new.ability(id)
    new(api_response) if is_success_response?(api_response)
  end
end