class CreateMpesas < ActiveRecord::Migration[5.1]
  def change
    create_table :mpesas do |t|
      t.string :merchant_request_id
      t.string :checkout_request_id
      t.string :response_description
      t.string :response_code
      t.string :customer_message
      t.string :result_code
      t.string :result_desc
      t.string :amount
      t.string :mpesa_receipt_number
      t.string :balance
      t.string :transaction_date
      t.string :phone_number
      t.references :customer, foreign_key: true
      t.string :kplc_token

      t.timestamps
    end
    add_index :mpesas, :merchant_request_id
    add_index :mpesas, :checkout_request_id
    add_index :mpesas, :mpesa_receipt_number
  end
end
