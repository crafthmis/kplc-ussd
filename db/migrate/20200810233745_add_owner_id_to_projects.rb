class AddOwnerIdToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :owner_id, :integer
    remove_column :projects, :user_id, :integer
  end
end
