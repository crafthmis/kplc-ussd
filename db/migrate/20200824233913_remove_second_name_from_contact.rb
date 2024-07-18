class RemoveSecondNameFromContact < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :second_name, :string
  end
end
