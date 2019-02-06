class Api::HerosController < ApplicationController

	def index
		render json: Hero.all
	end

	def show
		render json: Hero.find(params[:id])
	end

	def abilities
		render json: Hero.get_abilities(params[:id])
	end
end
