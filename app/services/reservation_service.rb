class ReservationService
  def initialize(req_body)
    @raw_data = req_body
    @body = JSON.parse(req_body, symbolize_names: true)
    @client_handler = nil

    if @body[:reservation_code]
      @client_handler = Clients::Airbnb.new()
    elsif @body[:reservation] && @body[:reservation][:code]
      @client_handler = Clients::Booking.new()
    end
  end

  def run()
    if !@client_handler
      return Clients::Errors.new('Invalid Body Format', 400)
    end

    begin
      reservation = @client_handler.parse_request_body(@body, @raw_data)
      persisted_rsv = Reservation.find_by(code: reservation.code, client: reservation.client)
      if persisted_rsv
        @client_handler.update!(persisted_rsv, reservation)
      else
        @client_handler.save!(reservation)
      end
    rescue ActiveRecord::RecordInvalid, Date::Error => e
      return Clients::Errors.new(e.to_s, 400)
    rescue => e
      return Clients::Errors.new(e.to_s, 500)
    end

    return nil
  end
end