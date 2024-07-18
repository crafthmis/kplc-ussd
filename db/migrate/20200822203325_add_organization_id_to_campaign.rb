class AddOrganizationIdToCampaign < ActiveRecord::Migration[5.2]
  def change
    add_reference :campaigns, :organization, foreign_key: true
  end
end
