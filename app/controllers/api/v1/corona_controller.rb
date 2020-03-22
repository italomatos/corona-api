# frozen_string_literal: true

module Api
  module V1
    class CoronaController < ApplicationController

      # all
      def index
        render json: corona_data
      end

      def ranking
        data = corona_data.each_with_index.map{|item, index| item.merge({position: index + 1})}.sort{|t1,t2| t2.fetch('cases') <=> t1.fetch('cases')}
        render json: data
      end

      protected

      def corona_data
        JSON.parse(HTTParty.get('https://corona.lmao.ninja/countries').body)
      end
    end
  end
end
