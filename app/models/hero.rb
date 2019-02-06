class Hero
  attr_accessor :id, :name, :real_name, :health, :armour, :shield

  def initialize(data_hash)
    @id = data_hash['id']
    @name = data_hash['name']
    @real_name = data_hash['real_name']
    @health = data_hash['health']
    @armour = data_hash['armour']
    @shield = data_hash['shield']
  end

  def self.find(id)
    api_response = OverwatchApi::Client.new.hero(id)
    new(api_response)
  end

  def self.all
    api_response = OverwatchApi::Client.new.heros
    api_response['data'] ? api_response['data'].map { |data| new(data) } : []
  end

  def self.get_abilities(id)
    api_response = OverwatchApi::Client.new.hero(id)
    api_response['abilities'].map { |data| Ability.new(data) }
  end
end