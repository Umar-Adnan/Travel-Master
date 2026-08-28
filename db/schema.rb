# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_28_160011) do
  create_table "alerts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "alert_type", null: false
    t.datetime "created_at", null: false
    t.bigint "destination_id"
    t.boolean "is_read", default: false
    t.text "message", null: false
    t.string "severity", default: "info"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["destination_id"], name: "index_alerts_on_destination_id"
    t.index ["user_id"], name: "index_alerts_on_user_id"
  end

  create_table "crowd_forecasts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "average_hotel_occupancy", default: 70
    t.datetime "created_at", null: false
    t.string "crowd_level", default: "Moderate"
    t.bigint "destination_id", null: false
    t.integer "intensity_percentage", default: 50
    t.string "month_or_season", null: false
    t.text "recommendations"
    t.string "season_type", default: "On-Season"
    t.datetime "updated_at", null: false
    t.index ["destination_id"], name: "index_crowd_forecasts_on_destination_id"
  end

  create_table "destinations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "available"
    t.string "best_season"
    t.datetime "booking_open_at"
    t.string "category"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.date "departure_date"
    t.text "description"
    t.integer "duration"
    t.string "image_url"
    t.boolean "is_domestic", default: false
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.string "name"
    t.text "popular_attractions"
    t.decimal "price", precision: 10
    t.decimal "rating", precision: 3, scale: 2, default: "4.5"
    t.datetime "updated_at", null: false
    t.index ["country"], name: "index_destinations_on_country"
  end

  create_table "hotels", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "address"
    t.text "amenities"
    t.integer "available_rooms", default: 10
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "destination_id", null: false
    t.string "hotel_type", default: "Hotel"
    t.string "image_url"
    t.string "name", null: false
    t.decimal "price_per_night", precision: 10, scale: 2, null: false
    t.integer "star_rating", default: 3
    t.datetime "updated_at", null: false
    t.index ["destination_id"], name: "index_hotels_on_destination_id"
  end

  create_table "routes_infos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "destination_city", null: false
    t.bigint "destination_id"
    t.decimal "distance_km", precision: 8, scale: 2, null: false
    t.decimal "estimated_drive_time_hours", precision: 5, scale: 2, null: false
    t.string "origin_city", null: false
    t.string "road_condition", default: "Good"
    t.text "route_highlights"
    t.string "route_name", null: false
    t.integer "scenic_score", default: 4
    t.decimal "toll_charges", precision: 8, scale: 2, default: "0.0"
    t.string "traffic_level", default: "Light"
    t.datetime "updated_at", null: false
    t.index ["destination_id"], name: "index_routes_infos_on_destination_id"
    t.index ["origin_city", "destination_city"], name: "index_routes_infos_on_origin_city_and_destination_city"
  end

  create_table "transports", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "arrival_time"
    t.string "comfort_class", default: "Standard"
    t.datetime "created_at", null: false
    t.string "departure_time"
    t.string "destination_city", null: false
    t.bigint "destination_id"
    t.integer "duration_minutes"
    t.decimal "eco_rating", precision: 3, scale: 1, default: "4.0"
    t.decimal "fare_price", precision: 10, scale: 2, null: false
    t.string "origin_city", null: false
    t.string "provider_name", null: false
    t.integer "seats_available", default: 20
    t.string "transport_type", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_id"], name: "index_transports_on_destination_id"
    t.index ["origin_city", "destination_city"], name: "index_transports_on_origin_city_and_destination_city"
  end

  create_table "trip_bookings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "bookable_id"
    t.string "bookable_type"
    t.string "booking_status", default: "estimated"
    t.datetime "created_at", null: false
    t.date "date"
    t.text "details"
    t.string "item_type", null: false
    t.integer "quantity", default: 1
    t.string "title", null: false
    t.decimal "total_cost", precision: 10, scale: 2, default: "0.0"
    t.bigint "trip_id", null: false
    t.decimal "unit_cost", precision: 10, scale: 2, default: "0.0"
    t.datetime "updated_at", null: false
    t.index ["bookable_type", "bookable_id"], name: "index_trip_bookings_on_bookable_type_and_bookable_id"
    t.index ["trip_id"], name: "index_trip_bookings_on_trip_id"
  end

  create_table "trip_destinations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "destination_id", null: false
    t.date "planned_arrival"
    t.integer "stay_days", default: 1
    t.bigint "trip_id", null: false
    t.datetime "updated_at", null: false
    t.integer "visit_order", default: 1
    t.index ["destination_id"], name: "index_trip_destinations_on_destination_id"
    t.index ["trip_id"], name: "index_trip_destinations_on_trip_id"
  end

  create_table "trips", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "budget_currency", default: "USD"
    t.datetime "created_at", null: false
    t.date "end_date", null: false
    t.text "notes"
    t.integer "number_of_travelers", default: 1
    t.date "start_date", null: false
    t.string "status", default: "Planned"
    t.decimal "target_budget", precision: 10, scale: 2
    t.string "title", null: false
    t.decimal "total_estimated_cost", precision: 10, scale: 2, default: "0.0"
    t.string "trip_type", default: "Personal"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "avatar_url"
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "default_currency", default: "USD"
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.string "phone_number"
    t.string "role", default: "user"
    t.string "travel_preference", default: "budget"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "weather_forecasts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "advisory_level", default: "Normal"
    t.string "condition", default: "Sunny"
    t.datetime "created_at", null: false
    t.bigint "destination_id", null: false
    t.date "forecast_date", null: false
    t.integer "humidity", default: 60
    t.integer "rainfall_prob", default: 10
    t.decimal "temperature_celsius", precision: 4, scale: 1, null: false
    t.text "travel_guidance"
    t.datetime "updated_at", null: false
    t.decimal "wind_speed_kmh", precision: 5, scale: 1, default: "12.0"
    t.index ["destination_id", "forecast_date"], name: "index_weather_forecasts_on_destination_id_and_forecast_date"
    t.index ["destination_id"], name: "index_weather_forecasts_on_destination_id"
  end

  add_foreign_key "alerts", "destinations"
  add_foreign_key "alerts", "users"
  add_foreign_key "crowd_forecasts", "destinations"
  add_foreign_key "hotels", "destinations"
  add_foreign_key "routes_infos", "destinations"
  add_foreign_key "transports", "destinations"
  add_foreign_key "trip_bookings", "trips"
  add_foreign_key "trip_destinations", "destinations"
  add_foreign_key "trip_destinations", "trips"
  add_foreign_key "trips", "users"
  add_foreign_key "weather_forecasts", "destinations"
end
