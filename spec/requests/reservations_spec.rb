require 'rails_helper'
require 'shared_payload'

RSpec.describe "Reservations", type: :request do
  include_context "shared payload"
  let(:callback_url) {'/reservations'}

  context "POST /reservations" do
    it 'should get 200 status to valid payload' do
      [payload1, payload2].each do |payload|
        post '/reservations', params: payload
        expect(response.status).to eq(200), payload
      end
    end

    it 'should get 200 status to update existing reservation' do
      params = JSON.parse(payload1, symbolize_names: true)
      req_client = "Airbnb"
      req_code = params[:reservation_code]
      req_guests = params[:guests]
      origin_guests = 1
      data = create(:reservation, client: req_client, code: req_code, guests: origin_guests)

      post '/reservations', params: payload1
      expect(response.status).to eq(200)
    end

    it 'should get 400 status to invalid payload' do
      [invalid_payload1].each do |payload|
        post callback_url, params: payload
        expect(response.status).to eq(400), payload
      end
    end
  end
end
