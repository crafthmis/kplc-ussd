class CreateIncidences < ActiveRecord::Migration[5.2]
  def change
    create_table :incidences do |t|
      t.string :kind
      t.string :explanation
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
