# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Coronas', type: :request do
  describe 'GET /api/v1/corona' do
    it '200 OK' do
      get api_v1_corona_path
      expect(response).to have_http_status(200)
    end

    it 'check return data' do
      get api_v1_corona_path
      expect(response.body).to include_json(
        [{ date: %r{\d+/\d+/\d+} }]
      )
    end
  end

  describe 'GET /api/v1/corona/:date' do
    it '200 OK' do
      get api_v1_corona_by_date_path(date: Time.now - 1.day)
      expect(response).to have_http_status(200)
    end

    it 'request with invalid date' do
      get api_v1_corona_by_date_path(date: '2020-02-31')
      expect(response).to have_http_status(404)
    end

    it 'request with valid date, but no data' do
      date = Time.now + 5.day
      get api_v1_corona_by_date_path(date: date)
      expect(response.body).to include_json(
        date: date.strftime('%d/%m/%Y'),
        data: []
      )
    end

    it 'request with valid date and valid country - BR' do
      date = Time.now - 5.day
      get api_v1_corona_by_date_path(date: date), params: { country: 'BR' }
      expect(response.body).to include_json(
        date: date.strftime('%d/%m/%Y'),
        data: [{ uid: 'BR' }]
      )
    end

    it 'request with valid date and valid country - BR - case insensitive' do
      date = Time.now - 5.day
      get api_v1_corona_by_date_path(date: date), params: { country: 'br' }
      expect(response.body).to include_json(
        date: date.strftime('%d/%m/%Y'),
        data: [{ uid: 'BR' }]
      )
    end

    it 'request with valid date and with invalid country' do
      date = Time.now - 5.day
      get api_v1_corona_by_date_path(date: date), params: { country: 'XY' }
      expect(response.body).to include_json(
        date: date.strftime('%d/%m/%Y')
      )
    end
  end
end
