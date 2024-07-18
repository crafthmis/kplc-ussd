class AddAdminToMembership < ActiveRecord::Migration[5.2]
  def change
    add_column :memberships, :admin, :boolean, null: false, default: false
  end
end
