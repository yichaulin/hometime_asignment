class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :email, :first_name, :last_name, :phone_numbers, null: false

      t.timestamps
    end

    add_index :guests, [:email], unique: true
  end
end
