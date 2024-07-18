class AddLatitudeAndLongitudeToIncidences < ActiveRecord::Migration[5.2]
  def change
    add_column :incidences, :latitude, :float
    add_index :incidences, :latitude
    add_column :incidences, :longitude, :float
    add_index :incidences, :longitude
  end
end
