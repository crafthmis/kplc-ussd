class AddAddressToIncidences < ActiveRecord::Migration[5.2]
  def change
    add_column :incidences, :full_address, :string
    add_column :incidences, :state, :string
    add_column :incidences, :county, :string
  end
end
