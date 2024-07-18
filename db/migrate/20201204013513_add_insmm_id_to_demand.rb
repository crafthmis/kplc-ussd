class AddInsmmIdToDemand < ActiveRecord::Migration[5.2]
  def change
    add_column :demands, :insmm_id, :integer
  end
end
