# {
#   "reservation_code": "YYY12345678",
#   "start_date": "2021-04-14",
#   "end_date": "2021-04-18",
#   "nights": 4,
#   "guests": 4,
#   "adults": 2,
#   "children": 2,
#   "infants": 0,
#   "status": "accepted",
#   "guest": {
#     "first_name": "Wayne",
#     "last_name": "Woodbridge",
#     "phone": "639123456789",
#     "email": "wayne_woodbridge@bnb.com"
#   },
#   "currency": "AUD",
#   "payout_price": "4200.00",
#   "security_price": "500",
#   "total_price": "4700.00"
# }

class Clients::Airbnb < Clients::Base
  def parse_request_body(body, raw_data)
    Reservation.new().tap do |r|
      r.client = Const::Client::Airbnb

      r.code = body[:reservation_code]
      r.start_date = DateTime.strptime(body[:start_date], '%Y-%m-%d')
      r.end_date = DateTime.strptime(body[:end_date], '%Y-%m-%d')
      r.nights = body[:nights]
      r.guests = body[:guests]
      r.adults = body[:adults]
      r.children = body[:children]
      r.infants = body[:infants]
      r.status = body[:status]
      r.currency = body[:currency]
      r.payout_amount = body[:payout_price]
      r.security_amount = body[:security_price]
      r.total_amount = body[:total_price]

      guest_params = body[:guest] || {}
      r.guest = create_or_update_guest(guest_params)
      r.raw_data = raw_data
    end
  end

  def create_or_update_guest(guest_params)
    email = guest_params[:email]
    Guest.find_or_initialize_by(email: email).tap do |g|
      g.first_name = guest_params[:first_name]
      g.last_name = guest_params[:last_name]
      g.phone_numbers = guest_params[:phone]
  
      g.save!
    end
  end
end