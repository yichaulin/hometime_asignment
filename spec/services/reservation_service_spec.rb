require 'rails_helper'
require 'shared_payload'

RSpec.describe ReservationService, type: :model do
  include_context "shared payload"

  context 'Create Reservation:' do
    it 'should verify and create reservation with payload#1' do
      params = JSON.parse(payload1, symbolize_names: true)
      rsv = ReservationService.new(params)
      rsv.run()
      
      data = Reservation.first
      expect(data.code).to eq('YYY12345678')
      expect(data.guest_email).to eq('wayne_woodbridge@bnb.com')
    end

    it 'should verify and create reservation with payload#2' do
      params = JSON.parse(payload2, symbolize_names: true)
      rsv = ReservationService.new(params)
      rsv.run()
      
      data = Reservation.first
      expect(data.code).to eq('XXX12345678')
      expect(data.guest_email).to eq('wayne_woodbridge@bnb.com')
      expect(data.guest_phone_numbers).to eq('639123456789,639123456789')
    end
  end

  context 'Update Reservation:' do
    it 'should update fields if client send request with same reservation code' do
      params = JSON.parse(payload1, symbolize_names: true)
      req_client = "Airbnb"
      req_code = params[:reservation_code]
      req_guests = params[:guests]
      origin_guests = 1

      data = create(:reservation, client: req_client, code: req_code, guests: origin_guests)
      expect(data.guests).to eq(origin_guests)

      rsv = ReservationService.new(params)
      rsv.run()
      data.reload

      expect(data.guests).to eq(req_guests)
    end
  end

  context 'Error handling:' do
    it 'should raise error if payload is invalid' do
      params = JSON.parse(invalid_payload1, symbolize_names: true)
      expect{ReservationService.new(params)}.to raise_error('Invalid Body Format')
    end
  end
end
