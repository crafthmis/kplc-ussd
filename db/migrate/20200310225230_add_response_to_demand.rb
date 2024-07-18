class AddResponseToDemand < ActiveRecord::Migration[5.1]
  def change
    add_column :demands, :response, :string
  end
end
