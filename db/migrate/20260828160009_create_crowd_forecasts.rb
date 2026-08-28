class CreateCrowdForecasts < ActiveRecord::Migration[8.1]
  def change
    create_table :crowd_forecasts do |t|
      t.references :destination, null: false, foreign_key: true
      t.string :month_or_season, null: false
      t.string :crowd_level, default: "Moderate" # Low, Moderate, High, Extreme Peak
      t.integer :intensity_percentage, default: 50 # 0 - 100
      t.string :season_type, default: "On-Season" # On-Season, Shoulder-Season, Off-Season
      t.text :recommendations
      t.integer :average_hotel_occupancy, default: 70

      t.timestamps
    end
  end
end
