class AddOrganizationIdToTeam < ActiveRecord::Migration[5.2]
  def change
    add_reference :teams, :organization, foreign_key: true
  end
end
