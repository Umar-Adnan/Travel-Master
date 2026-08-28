class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :role, default: "user"
      t.string :phone_number
      t.string :travel_preference, default: "budget"
      t.string :default_currency, default: "USD"
      t.text :bio
      t.string :avatar_url

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
