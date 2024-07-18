class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.boolean :ussd_sms
      t.boolean :prepaid_token
      t.boolean :postpaid_token
      t.boolean :find_contractor
      t.boolean :find_employee
      t.boolean :short_code

      t.timestamps
    end
  end
end
