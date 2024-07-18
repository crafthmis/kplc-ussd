class RemovePhoneNumberFromRequest < ActiveRecord::Migration[5.1]
  def change
    remove_column :requests, :phone_number, :string
  end
end
