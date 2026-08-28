class CreateTransports < ActiveRecord::Migration[8.1]
  def change
    create_table :transports do |t|
      t.references :destination, foreign_key: true, null: true
      t.string :origin_city, null: false
      t.string :destination_city, null: false
      t.string :transport_type, null: false # Flight, Train, Bus, Car Rental, Private Transfer
      t.string :provider_name, null: false
      t.string :departure_time
      t.string :arrival_time
      t.integer :duration_minutes
      t.decimal :fare_price, precision: 10, scale: 2, null: false
      t.integer :seats_available, default: 20
      t.string :comfort_class, default: "Standard" # Economy, Business, First, Standard
      t.decimal :eco_rating, precision: 3, scale: 1, default: 4.0

      t.timestamps
    end
    add_index :transports, [:origin_city, :destination_city]
  end
end
