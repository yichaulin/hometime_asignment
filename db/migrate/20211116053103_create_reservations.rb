class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :code, :guest_email, :guest_first_name, :guest_last_name, index: true, null: false
      t.string :guest_phone_numbers, :status, :currency, null: false
      t.datetime :start_date, null: false, index: true
      t.datetime :end_date, null: false, index: true
      t.integer :nights, :guests, :adults, :children, :infants, default: 0
      t.string :guest_description
      t.decimal :payout_amount, :security_amount, :total_amount , precision: 10, scale: 2, default: 0
      t.timestamps
    end
  end
end
