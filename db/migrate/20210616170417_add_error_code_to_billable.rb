class AddErrorCodeToBillable < ActiveRecord::Migration[5.2]
  def change
    add_column :billables, :error_code, :string
  end
end
