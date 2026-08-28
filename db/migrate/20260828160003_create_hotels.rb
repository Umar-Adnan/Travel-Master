class CreateHotels < ActiveRecord::Migration[8.1]
  def change
    create_table :hotels do |t|
      t.references :destination, null: false, foreign_key: true
      t.string :name, null: false
      t.string :hotel_type, default: "Hotel"
      t.string :address
      t.integer :star_rating, default: 3
      t.decimal :price_per_night, precision: 10, scale: 2, null: false
      t.integer :available_rooms, default: 10
      t.text :amenities
      t.string :image_url
      t.text :description
      t.string :contact_number

      t.timestamps
    end
  end
end
