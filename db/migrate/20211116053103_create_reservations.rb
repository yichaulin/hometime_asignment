class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :guest_id, index: true, null: false
      t.string :code, :client, index: true, null: false
      t.string :guest_phone_numbers, :status, :currency, :raw_data, null: false
      t.datetime :start_date, null: false, index: true
      t.datetime :end_date, null: false, index: true
      t.integer :nights, :guests, :adults, :children, :infants, default: 0
      t.string :guest_description
      t.decimal :payout_amount, :security_amount, :total_amount , precision: 10, scale: 2, default: 0
      t.timestamps
    end

    add_index :reservations, [:code, :client], unique: true
  end
end
