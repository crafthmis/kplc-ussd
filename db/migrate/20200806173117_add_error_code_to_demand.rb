class AddErrorCodeToDemand < ActiveRecord::Migration[5.1]
  def change
    add_column :demands, :error_code, :integer
  end
end
