class Api::AbilitiesController < ApplicationController
	
	# GET
  # return: list of abilities
  def index
    render_response(Ability.all)
  end
  
  # GET
  # params: id - ability id
  # return: ability details
  def show
    render_response(Ability.find(params[:id]))
  end
end
