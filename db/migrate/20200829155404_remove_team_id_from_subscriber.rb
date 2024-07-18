class RemoveTeamIdFromSubscriber < ActiveRecord::Migration[5.2]
  def change
    remove_reference :subscribers, :team, foreign_key: true
  end
end
