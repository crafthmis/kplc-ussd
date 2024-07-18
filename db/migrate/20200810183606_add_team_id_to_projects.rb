class AddTeamIdToProjects < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :team, foreign_key: true
  end
end
