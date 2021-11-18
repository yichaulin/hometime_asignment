FactoryBot.define do
  factory :reservation do
    guest { create(:guest) }
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
    currency { "AUD" }
    payout_amount { 4200.00 }
    security_amount { 500 }
    total_amount { 4700.00 }
    raw_data { "raw_data" }
  end
end