class Api::V1::CoronaController < ApplicationController
  def index
  	response = HTTParty.get('http://plataforma.saude.gov.br/novocoronavirus/resources/scripts/database.js')
  	render json: response.body.slice('var database=')
  end
end
