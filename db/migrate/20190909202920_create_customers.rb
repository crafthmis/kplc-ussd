class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :number

      t.timestamps
    end
    add_index :customers, :number
  end
end
