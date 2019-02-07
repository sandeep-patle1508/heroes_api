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

  # call Overwatch hero API to get lits of heros
  # return: Array of Hero objects
  def self.all
    api_response = OverwatchApi::Client.new.heros
    api_response['data'] ? api_response['data'].map { |data| new(data) } : []
  end

  # call Overwatch hero API with given ID
  # return: Hero object
  def self.find(id)
    api_response = OverwatchApi::Client.new.hero(id)
    new(api_response)
  end

  # call Overwatch hero API with given ID
  # return: Parse and return Ability object
  def self.get_abilities(id)
    api_response = OverwatchApi::Client.new.hero(id)
    api_response['abilities'] ? api_response['abilities'].map { |data| Ability.new(data) } : []
  end
end