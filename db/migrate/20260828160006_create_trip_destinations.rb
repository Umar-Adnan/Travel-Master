class CreateTripDestinations < ActiveRecord::Migration[8.1]
  def change
    create_table :trip_destinations do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :destination, null: false, foreign_key: true
      t.integer :visit_order, default: 1
      t.integer :stay_days, default: 1
      t.date :planned_arrival

      t.timestamps
    end
  end
end
