class Reservation < ApplicationRecord
  validates_presence_of :code, :guest_email, :guest_first_name, :guest_last_name, :guest_phone_numbers, :status, :currency, :start_date, :end_date
end
