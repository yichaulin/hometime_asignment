class Clients::Base
  UpdatableColumns = [:start_date, :end_date, :payout_amount, :adults, :children, :infants, :security_amount, :currency, :nights, :guests, :status, :total_amount]

  def save!(rsv)
    rsv.save!
  end

  def update!(persisted_rsv, rsv)
    if !persisted_rsv.is_a?(Reservation) || !rsv.is_a?(Reservation)
      raise "One of args is not `Reservation` instance"
    end

    updatable_columns().each do |column|
      persisted_rsv[column] = rsv[column]
    end

    persisted_rsv.save!
  end

  protected

  def updatable_columns()
    self.class::UpdatableColumns
  end
end