# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Coronas', type: :request do
  describe 'GET /api/v1/corona' do
    it '200 OK' do
      get api_v1_corona_path
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET /api/v1/corona/ranking' do
    it '200 OK' do
      get api_v1_corona_ranking_path
      expect(response).to have_http_status(200)
    end
  end
end
