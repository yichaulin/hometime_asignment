class ReservationService
  def initialize(body)
    @body = body
  end

  def run()
    res, err = validate_client()
    if err
      return nil, err
    end
    
    return res, nil
  end

  private

  def validate_client()
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