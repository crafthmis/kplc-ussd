class CreateReadings < ActiveRecord::Migration[5.1]
  def change
    create_table :readings do |t|
      t.string :number
      t.references :account, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
