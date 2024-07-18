class AddEmailToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :email_notification, :boolean , null: false, default: false
    add_column :customers, :sms_notification, :boolean, null: false, default: false
    add_column :customers, :email, :string
  end
end
