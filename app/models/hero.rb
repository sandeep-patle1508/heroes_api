class Hero
  attr_accessor :id, :name, :real_name, :health, :armour, :shield

  def initialize(data_hash)
    @id = data_hash[:id]
    @name = data_hash[:name]
    @real_name = data_hash[:real_name]
    @health = data_hash[:health]
    @armour = data_hash[:armour]
    @shield = data_hash[:shield]
  end
end