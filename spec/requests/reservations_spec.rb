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

    it 'should get 400 status to invalid payload' do
      [invalid_payload1].each do |payload|
        post callback_url, params: payload
        expect(response.status).to eq(400), payload
      end
    end
  end
end
