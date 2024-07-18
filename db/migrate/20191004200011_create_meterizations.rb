class CreateMeterizations < ActiveRecord::Migration[5.1]
  def change
    create_table :meterizations do |t|
      t.integer :customer_id
      t.integer :meter_id

      t.timestamps
    end
    add_index :meterizations, :customer_id
    add_index :meterizations, :meter_id
  end
end
