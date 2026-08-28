class CreateTrips < ActiveRecord::Migration[8.1]
  def change
    create_table :trips do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :trip_type, default: "Personal" # Personal, Group Vacation, Business Meeting, Solo
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :number_of_travelers, default: 1
      t.string :budget_currency, default: "USD"
      t.decimal :target_budget, precision: 10, scale: 2
      t.decimal :total_estimated_cost, precision: 10, scale: 2, default: 0.0
      t.string :status, default: "Planned" # Draft, Planned, Booked, Completed, Cancelled
      t.text :notes

      t.timestamps
    end
  end
end
