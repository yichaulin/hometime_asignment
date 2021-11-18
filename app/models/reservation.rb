class Reservation < ApplicationRecord
  belongs_to :guest

  validates_presence_of :code, :guest_email, :guest_first_name, :guest_last_name, :guest_phone_numbers, :status, :currency, :start_date, :end_date, :raw_data
end
