class AddIndexToDestinationsCountry < ActiveRecord::Migration[8.1]
  def change
    add_index :destinations, :country
  end
end
