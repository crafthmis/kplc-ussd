class CreateDemands < ActiveRecord::Migration[5.1]
  def change
    create_table :demands do |t|
      t.string :request_id
      t.string :request_timestamp
      t.string :channel
      t.string :operation
      t.string :offer_code
      t.references :customer, foreign_key: true
      t.string :link_id
      t.string :content

      t.timestamps
    end
  end
end
