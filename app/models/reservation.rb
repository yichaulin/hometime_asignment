class Reservation < ApplicationRecord
  belongs_to :guest

  validates_presence_of :code, :status, :currency, :start_date, :end_date, :raw_data
end
