class CreateEquities < ActiveRecord::Migration[5.2]
  def change
    create_table :equities do |t|
      t.references :customer, foreign_key: true
      t.string :amount
      t.string :status
      t.references :equitable, polymorphic: true

      t.timestamps
    end
  end
end
