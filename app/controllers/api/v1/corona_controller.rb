class Api::V1::CoronaController < ApplicationController

  def find_by_date

  date = (params[:date] ? params[:date] : (Time.now - 1.day))

	begin
    date = date.to_date.strftime('%d/%m/%Y')
    country = params[:country]
    result = corona_data.find{ |item| item['date'] == date }
    result = {} if result.nil?
    result = result['values'].find{|item| item['uid'].eql? (params[:country])} if country

    render json: result.merge({date: date})
	rescue ArgumentError
    render json: { status: 'not_found' }, status: :not_found
	end



  end

  #all
  def index
  	render json: corona_data
  end

  protected
  def corona_data
  	response = HTTParty.get('http://plataforma.saude.gov.br/novocoronavirus/resources/scripts/database.js')
  	JSON.parse(response.body.gsub('var database=', ''))['world']
  end
end
