class CreateAccountments < ActiveRecord::Migration[5.1]
  def change
    create_table :accountments do |t|
      t.integer :customer_id
      t.integer :account_id

      t.timestamps
    end
    add_index :accountments, :customer_id
    add_index :accountments, :account_id
  end
end
