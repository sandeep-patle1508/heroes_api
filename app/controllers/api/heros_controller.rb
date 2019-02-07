class Api::HerosController < ApplicationController

  # GET
  # return: list of heros
  def index
    render json: Hero.all
  end
  
  # GET
  # params: id - hero id
  # return: hero details
  def show
    render json: Hero.find(params[:id])
  end

  # GET
  # params: id - hero id
  # return: list of abilities for an hero 
  def abilities
    render json: Hero.get_abilities(params[:id])
  end
end
