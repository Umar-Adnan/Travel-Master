class EnhanceDestinations < ActiveRecord::Migration[8.1]
  def change
    add_column :destinations, :category, :string
    add_column :destinations, :image_url, :string
    add_column :destinations, :latitude, :decimal, precision: 10, scale: 6
    add_column :destinations, :longitude, :decimal, precision: 10, scale: 6
    add_column :destinations, :best_season, :string
    add_column :destinations, :is_domestic, :boolean, default: false
    add_column :destinations, :rating, :decimal, precision: 3, scale: 2, default: 4.5
    add_column :destinations, :popular_attractions, :text
  end
end
