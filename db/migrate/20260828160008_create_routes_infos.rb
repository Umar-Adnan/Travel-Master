class CreateRoutesInfos < ActiveRecord::Migration[8.1]
  def change
    create_table :routes_infos do |t|
      t.references :destination, foreign_key: true, null: true
      t.string :origin_city, null: false
      t.string :destination_city, null: false
      t.string :route_name, null: false
      t.decimal :distance_km, precision: 8, scale: 2, null: false
      t.decimal :estimated_drive_time_hours, precision: 5, scale: 2, null: false
      t.string :road_condition, default: "Good" # Excellent, Good, Moderate, Under Maintenance
      t.decimal :toll_charges, precision: 8, scale: 2, default: 0.0
      t.integer :scenic_score, default: 4 # 1 - 5
      t.string :traffic_level, default: "Light" # Light, Moderate, Heavy
      t.text :route_highlights

      t.timestamps
    end
    add_index :routes_infos, [:origin_city, :destination_city]
  end
end
