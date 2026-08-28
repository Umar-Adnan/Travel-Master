class CreateDestination < ActiveRecord::Migration[8.1]
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :country
      t.string :city
      t.text :description
      t.decimal :price
      t.boolean :available
      t.integer :duration
      t.date :departure_date
      t.datetime :booking_open_at
      t.timestamps
    end
    
  end
end
