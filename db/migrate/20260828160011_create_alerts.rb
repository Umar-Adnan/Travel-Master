class CreateAlerts < ActiveRecord::Migration[8.1]
  def change
    create_table :alerts do |t|
      t.references :user, foreign_key: true, null: true
      t.references :destination, foreign_key: true, null: true
      t.string :alert_type, null: false # weather, route, crowd, price_drop, booking
      t.string :title, null: false
      t.text :message, null: false
      t.string :severity, default: "info" # info, warning, critical, success
      t.boolean :is_read, default: false

      t.timestamps
    end
  end
end
