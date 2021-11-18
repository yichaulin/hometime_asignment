require 'rails_helper'
require 'shared_payload'

RSpec.describe ReservationService, type: :model do
  include_context "shared payload"

  context 'Create Reservation:' do
    it 'should verify and create reservation with payload#1' do
      err = ReservationService.new(payload1).run()
      expect(err).to be_nil
      
      data = Reservation.first
      expect(data.code).to eq('YYY12345678')
      expect(data.guest.email).to eq('wayne_woodbridge@bnb.com')
    end

    it 'should verify and create reservation with payload#2' do
      err = ReservationService.new(payload2).run()
      expect(err).to be_nil
      
      data = Reservation.first
      expect(data.code).to eq('XXX12345678')
      expect(data.guest.email).to eq('wayne_woodbridge@bnb.com')
      expect(data.guest.phone_numbers).to eq('639123456789,639123456789')
    end
  end

  context 'Update Reservation:' do
    it 'should update guests number if client send request with same reservation code' do
      params = JSON.parse(payload1, symbolize_names: true)
      req_client = "Airbnb"
      req_code = params[:reservation_code]
      req_guests = params[:guests]
      origin_guests = 1

      data = create(:reservation, client: req_client, code: req_code, guests: origin_guests)
      err = ReservationService.new(payload1).run()
      expect(err).to be_nil

      data.reload
      expect(data.guests).to eq(req_guests)
    end

    it 'should update guest phone number if client send request with same reservation code' do
      params = JSON.parse(payload1, symbolize_names: true)
      req_client = "Airbnb"
      req_code = params[:reservation_code]
      req_phone_numbers = params[:guest][:phone]
      origin_phone_numbers = "12345678"
      guest = create(:guest, phone_numbers: origin_phone_numbers)

      data = create(:reservation, client: req_client, code: req_code, guest: guest)

      err = ReservationService.new(payload1).run()
      expect(err).to be_nil

      data.reload
      expect(data.guest.phone_numbers).to eq(req_phone_numbers)
    end
  end

  context 'Error handling:' do
    it 'should raise error if payload is invalid' do
      err = ReservationService.new(invalid_payload1).run()
      expect(err).to be_instance_of(Clients::Errors)
      expect(err.message).to eql("Invalid Body Format")
      expect(err.http_status).to be(400)
    end
  end
end
