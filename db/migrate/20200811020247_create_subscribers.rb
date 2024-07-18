class CreateSubscribers < ActiveRecord::Migration[5.1]
  def change
    create_table :subscribers do |t|
      t.references :audience, foreign_key: true
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
