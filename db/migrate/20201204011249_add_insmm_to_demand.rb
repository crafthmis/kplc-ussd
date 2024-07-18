class AddInsmmToDemand < ActiveRecord::Migration[5.2]
  def change
    add_column :demands, :insmm, :boolean, null: false , default: false
  end
end
