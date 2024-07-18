class RemoveUserIdFromTeams < ActiveRecord::Migration[5.1]
  def change
    remove_column :teams, :user_id, :integer
  end
end
