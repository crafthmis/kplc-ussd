class AddServiceToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :service, :integer
    add_index :messages, :service
  end
end
