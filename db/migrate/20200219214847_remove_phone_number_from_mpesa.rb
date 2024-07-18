class RemovePhoneNumberFromMpesa < ActiveRecord::Migration[5.1]
  def change
    remove_column :mpesas, :phone_number, :string
    remove_column :mpesas, :balance, :string
  end
end
