class ReservationService
  def initialize(body)
    @body = body

    if @body[:reservation_code]
      @client_handler = Clients::Airbnb.new()
    elsif @body[:reservation] && @body[:reservation][:code]
      @client_handler = Clients::Booking.new()
    else
      raise "Invalid Body Format"
    end
  end

  def run()
    reservation, err = @client_handler.parse_request_body(@body)
    return err if err

    persisted_rsv = Reservation.find_by(code: reservation.code, client: reservation.client)
    if persisted_rsv
      @client_handler.update!(persisted_rsv, reservation)
    else
      @client_handler.save!(reservation)
    end
    
    return nil
  end
end