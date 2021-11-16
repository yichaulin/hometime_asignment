class ReservationService
  def initialize(body)
    @body = body
  end

  def run()
    reservation, err = parse_body()
    return nil, err if err

    reservation.save!
    
    return reservation, nil
  end

  private

  def parse_body()
    if @body[:reservation_code]
      reservation = Clients::Airbnb.parse_request_body(@body)
      return reservation, nil
    elsif @body[:reservation] && @body[:reservation][:code]
      reservation = Clients::Booking.parse_request_body(@body)
      return reservation, nil
    else
      return nil, "Invalid Body Format"
    end
  end
end