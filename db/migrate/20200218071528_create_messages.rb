class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.string :code
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
