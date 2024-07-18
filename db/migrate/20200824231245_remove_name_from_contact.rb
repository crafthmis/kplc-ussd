class RemoveNameFromContact < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :name, :string
  end
end
