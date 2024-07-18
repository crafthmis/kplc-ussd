class AddStatusCodeToBillables < ActiveRecord::Migration[5.2]
  def change
    add_column :billables, :status_code, :string
    add_column :billables, :description, :string
  end
end
