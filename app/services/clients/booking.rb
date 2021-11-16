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

class Clients::Booking
  def self.parse_request_body(body)
    rsv = body[:reservation]
    return nil if !rsv

    Reservation.new().tap do |r|
      r.client = Const::Client::Booking

      r.code = rsv[:code]
      r.start_date = DateTime.strptime(rsv[:start_date], '%Y-%m-%d')
      r.end_date = DateTime.strptime(rsv[:end_date], '%Y-%m-%d')
      r.payout_amount = rsv[:expected_payout_amount]

      guest_details = rsv[:guest_details] || {}
      r.guest_description = guest_details[:localized_description]
      r.adults = guest_details[:number_of_adults]
      r.children = guest_details[:number_of_children]
      r.infants = guest_details[:number_of_infants]


      r.guest_email = rsv[:guest_email]
      r.guest_first_name = rsv[:guest_first_name]
      r.guest_last_name = rsv[:guest_last_name]
      r.guest_phone_numbers = rsv[:guest_phone_numbers].join(',')
      r.security_amount = rsv[:listing_security_price_accurate]
      r.currency = rsv[:host_currency]
      r.nights = rsv[:nights]
      r.guests = rsv[:number_of_guests]
      r.status = rsv[:status_type]
      r.total_amount = rsv[:total_paid_amount_accurate]
    end
  end
end