class Api::HerosController < ApplicationController

  # GET
  # return: list of heros
  def index
    render_response(Hero.all)
  end
  
  # GET
  # params: id - hero id
  # return: hero details
  def show
    render_response(Hero.find(params[:id]))
  end

  # GET
  # params: id - hero id
  # return: list of abilities for an hero 
  def abilities
    render_response(Hero.get_abilities(params[:id]))
  end
end
