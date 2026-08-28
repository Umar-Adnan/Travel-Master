class CreateWeatherForecasts < ActiveRecord::Migration[8.1]
  def change
    create_table :weather_forecasts do |t|
      t.references :destination, null: false, foreign_key: true
      t.date :forecast_date, null: false
      t.decimal :temperature_celsius, precision: 4, scale: 1, null: false
      t.string :condition, default: "Sunny" # Sunny, Rainy, Cloudy, Partly Cloudy, Snow, Thunderstorm
      t.integer :humidity, default: 60
      t.decimal :wind_speed_kmh, precision: 5, scale: 1, default: 12.0
      t.integer :rainfall_prob, default: 10 # 0 - 100
      t.text :travel_guidance
      t.string :advisory_level, default: "Normal" # Normal, Advisory, Severe Warning

      t.timestamps
    end
    add_index :weather_forecasts, [:destination_id, :forecast_date]
  end
end
