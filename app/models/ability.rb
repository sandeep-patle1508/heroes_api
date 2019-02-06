class Ability
  attr_accessor :id, :name, :description, :is_ultimate

  def initialize(data_hash)
    @id = data_hash['id']
    @name = data_hash['name']
    @real_name = data_hash['description']
    @health = data_hash['is_ultimate']
  end

  def self.find(id)
    api_response = OverwatchApi::Client.new.ability(id)
    new(api_response)
  end

  def self.all
    api_response = OverwatchApi::Client.new.abilities
    api_response[:data].map { |data| new(data) }
  end
end