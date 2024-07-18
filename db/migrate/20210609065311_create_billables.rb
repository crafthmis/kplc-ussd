class CreateBillables < ActiveRecord::Migration[5.2]
  def change
    create_table :billables do |t|
      t.string :request_id
      t.string :request_timestamp
      t.string :response_id
      t.string :channel
      t.string :offer_code
      t.references :customer, foreign_key: true
      t.string :content
      t.references :meter, foreign_key: true
      t.references :account, foreign_key: true
      t.string :response

      t.timestamps
    end
  end
end
