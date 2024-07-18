class AddNumberIdToAccount < ActiveRecord::Migration[5.1]
  def change
    add_index :accounts, :number
  end
end
