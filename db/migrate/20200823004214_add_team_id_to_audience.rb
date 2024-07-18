class AddTeamIdToAudience < ActiveRecord::Migration[5.2]
  def change
    add_reference :audiences, :team, foreign_key: true
    add_reference :campaigns, :team, foreign_key: true
    add_reference :subscribers, :team, foreign_key: true
    add_reference :sms_templates, :team, foreign_key: true
  end
end
