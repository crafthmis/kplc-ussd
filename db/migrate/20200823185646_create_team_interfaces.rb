class CreateTeamInterfaces < ActiveRecord::Migration[5.2]
  def change
    create_table :team_interfaces do |t|
      t.references :team, foreign_key: true
      t.references :organization_interface, foreign_key: true
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
