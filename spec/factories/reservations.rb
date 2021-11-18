FactoryBot.define do
  factory :reservation do
    client { "Airbnb" }
    code { "YYY12345678" }
    start_date { "2021-04-14" }
    end_date { "2021-04-18" }
    nights { 4 }
    guests { 4 }
    adults { 2 }
    children { 2 }
    infants { 0 }
    status { "accepted" }
    guest_first_name { "Wayne" }
    guest_last_name { "Woodbridge" }
    guest_phone_numbers { "639123456789" }
    guest_email { "wayne_woodbridge@bnb.com" }
    currency { "AUD" }
    payout_amount { 4200.00 }
    security_amount { 500 }
    total_amount { 4700.00 }
    raw_data { "raw_data" }
  end
end