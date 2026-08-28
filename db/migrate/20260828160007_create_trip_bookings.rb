class CreateTripBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :trip_bookings do |t|
      t.references :trip, null: false, foreign_key: true
      t.string :bookable_type
      t.bigint :bookable_id
      t.string :item_type, null: false # hotel, transport, activity, food, toll_fuel, custom
      t.string :title, null: false
      t.decimal :unit_cost, precision: 10, scale: 2, default: 0.0
      t.integer :quantity, default: 1
      t.decimal :total_cost, precision: 10, scale: 2, default: 0.0
      t.string :booking_status, default: "estimated" # estimated, reserved, confirmed
      t.text :details
      t.date :date

      t.timestamps
    end
    add_index :trip_bookings, [:bookable_type, :bookable_id]
  end
end
