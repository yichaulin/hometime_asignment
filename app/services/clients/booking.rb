# {
#   "reservation": {
#     "code": "XXX12345678",
#     "start_date": "2021-03-12",
#     "end_date": "2021-03-16",
#     "expected_payout_amount": "3800.00",
#     "guest_details": {
#       "localized_description": "4 guests",
#       "number_of_adults": 2,
#       "number_of_children": 2,
#       "number_of_infants": 0
#     },
#     "guest_email": "wayne_woodbridge@bnb.com",
#     "guest_first_name": "Wayne",
#     "guest_last_name": "Woodbridge",
#     "guest_phone_numbers": [
#       "639123456789",
#       "639123456789"
#     ],
#     "listing_security_price_accurate": "500.00",
#     "host_currency": "AUD",
#     "nights": 4,
#     "number_of_guests": 4,
#     "status_type": "accepted",
#     "total_paid_amount_accurate": "4300.00"
#   }
# }

class Clients::Booking < Clients::Base
  def parse_request_body(body, raw_data)
    rsv = body[:reservation]
    return Reservation.new() if !rsv

    Reservation.new().tap do |r|
      r.client = Const::Client::Booking

      r.code = rsv[:code]
      r.start_date = DateTime.strptime(rsv[:start_date], '%Y-%m-%d')
      r.end_date = DateTime.strptime(rsv[:end_date], '%Y-%m-%d')
      r.payout_amount = rsv[:expected_payout_amount]

      guest_details = rsv[:guest_details] || {}
      r.notes = guest_details[:localized_description]
      r.adults = guest_details[:number_of_adults]
      r.children = guest_details[:number_of_children]
      r.infants = guest_details[:number_of_infants]

      r.security_amount = rsv[:listing_security_price_accurate]
      r.currency = rsv[:host_currency]
      r.nights = rsv[:nights]
      r.guests = rsv[:number_of_guests]
      r.status = rsv[:status_type]
      r.total_amount = rsv[:total_paid_amount_accurate]

      r.guest = create_or_update_guest(rsv)
      r.raw_data = raw_data
    end
  end

  def create_or_update_guest(guest_params)
    email = guest_params[:guest_email]

    Guest.find_or_initialize_by(email: email).tap do |g|
      g.first_name = guest_params[:guest_first_name]
      g.last_name = guest_params[:guest_last_name]
      g.phone_numbers = guest_params[:guest_phone_numbers].join(',')
  
      g.save!
    end
  end
end