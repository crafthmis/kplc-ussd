class CreateMeters < ActiveRecord::Migration[5.1]
  def change
    create_table :meters do |t|
      t.string :number
      t.boolean :status ,null: false, default: false

      t.timestamps
    end
  end
end
